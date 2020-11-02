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
            
            guard let animals = result else {
                self.presenterDelegate?.loadAnimalsFailure(error: error!)
                return
            }
            //Start Task 2
//            let dGroup = DispatchGroup()
            for animal in animals {
                guard let id = animal.familyID else {
                    continue
                }
                
//                dGroup.enter()
                WORMSService.getVernacular(id: id) {name in
                    print(name)// TODO: Save name in animal struct? animal.vernacular = name
//                    dGroup.leave()
                }
            }
//            dGroup.wait()
            print("All done?")
        }
    }
}

//extension AnimalListInteractor: OBISServiceDelegate {
//    func didSuccessfullyReturn(_ animals: [Animal]) {
//        for animal in animals {
//            guard animal.familyID != nil else {
//                break
//            }
//            let service = WORMSService()
//            service.getVernacular(id: animal.familyID!, delegate: InlineDelegate(animal: animal, superDelegate: self.presenterDelegate!))
//        }
//        presenterDelegate?.loadAnimalsSuccess(animals: animals)
//    }
//
//    func didFailWithError(_ error: String) {
//        presenterDelegate?.loadAnimalsFailure(error: error)
//    }
//
//    func updateStatus(_ status: String) {
//        presenterDelegate?.loadAnimalsStatusUpdate(status: status)
//    }
//}
