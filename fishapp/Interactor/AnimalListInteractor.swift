//
//  AnimalListInteractor.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

protocol AnimalListInteractorDelegate {
    func loadAnimalsSuccess(animals: [Animal])
    func loadAnimalsFailure(error: String)
    func loadAnimalsStatusUpdate(status: String)
    func refreshAnimal(animal:Animal)
}

class AnimalListInteractor {
    
    var location: Location?
    
    var presenterDelegate: AnimalListInteractorDelegate?
    
    func loadAnimals() {
        /*
         Task 1
         - get all animals (1-request)
         - Parse to [Animal]
         
         Task 2
         - get vernacular names for animals (up to 100s of requests)
         - Parse result and update presenter
         */
        guard let location = location else {
            presenterDelegate?.loadAnimalsFailure(error: "No location set")
            return
        }
        
        OBISService.getCheckList(location: location, onStatus: {
            self.presenterDelegate?.loadAnimalsStatusUpdate(status: $0)
        }) { result in
            switch result {
            case .success(var animals):
                DispatchQueue.global(qos: .userInitiated).async {
                    let dGroup = DispatchGroup()
                    for index in 0..<animals.count {
                        guard let id = animals[index].familyID else {
                            continue
                        }
                        
                        dGroup.enter()
                        WORMSService.getVernacular(id: id) {result in
                            switch result {
                            case .success(let name):
                                animals[index].vernacular = name
                            case .failure(_):
                                break
                                //Nothing to do
                            }
                            dGroup.leave()
                        }
                    }
                    
                    dGroup.wait()
                    self.presenterDelegate?.loadAnimalsSuccess(animals: animals)
                }
            case .failure(let error):
                self.presenterDelegate?.loadAnimalsFailure(error: error.localizedDescription)
            }
        }
    }
}
