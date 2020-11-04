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
        }) { result, error in
            guard error == nil else {
                self.presenterDelegate?.loadAnimalsFailure(error: error!)
                return
            }
            
            guard var animals = result else {
                self.presenterDelegate?.loadAnimalsFailure(error: error!)
                return
            }
            DispatchQueue.global(qos: .userInitiated).async {
                let dGroup = DispatchGroup()
                for index in 0..<animals.count {
                    guard let id = animals[index].familyID else {
                        continue
                    }
                    
                    dGroup.enter()
                    WORMSService.getVernacular(id: id) {name in
                        animals[index].vernacular = name
                        dGroup.leave()
                    }
                }
                
                
                dGroup.wait()
                self.presenterDelegate?.loadAnimalsSuccess(animals: animals)
            }
        }
    }
}
