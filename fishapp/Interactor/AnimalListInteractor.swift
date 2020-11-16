//
//  AnimalListInteractor.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

protocol AnimalListInteractorDelegate {
    func loadAnimalsSuccess()
    func loadAnimalsFailure(error: String)
    func loadAnimalsStatusUpdate(status: String)
    func refreshAnimal(animal:Family)
}

class AnimalListInteractor {
    
    var animals: [Family]?
    
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
            case .success(let result):
                var families = [Family]()
                for species in result.results {
                    guard species.familyid != nil else {
                        break
                    }
                    var alreadyAdded = false
                    for fam in families {
                        if species.familyid == fam.familyID {
                            if let name = species.species ?? species.scientificName {
                                fam.species.append(name)
                            }
                            alreadyAdded = true
                            break
                        }
                    }
                    if !alreadyAdded {
                        let new = Family()
                        new.family = species.family
                        new.familyID = species.familyid
                        new.genus = species.genus
                        new.kingdom = species.genus
                        new.phylum = species.phylum
                        new.subphylum = species.subphylum
                        new.superclass = species.superclass
                        new.aclass = species.aclass
                        new.subclass = species.subclass
                        new.order = species.order
                        new.records = species.records
                        new.subfamily = species.subfamily
                        new.superfamily = species.superfamily
                        new.category = species.category
                        new.vernacular = nil
                        new.risk = self.getRisk(species.familyid!)
                        families.append(new)
                    }
                }
                DispatchQueue.global(qos: .userInitiated).async {
                    let dGroup = DispatchGroup()
                    for index in 0..<families.count {
                        guard let id = families[index].familyID else {
                            continue
                        }
                        
                        dGroup.enter()
                        WORMSService.getVernacular(id: id) {result in
                            switch result {
                            case .success(let name):
                                families[index].vernacular = name
                            case .failure(_):
                                break
                                //Nothing to do
                            }
                            dGroup.leave()
                        }
                    }
                    
                    dGroup.wait()
                    self.animals = families
                    self.presenterDelegate?.loadAnimalsSuccess()
                }
            case .failure(let error):
                self.presenterDelegate?.loadAnimalsFailure(error: error.localizedDescription)
            }
        }
    }
    
    func getRisk(_ familyId: Int) -> Risk {
        switch familyId {
        case 111:
            fallthrough
        case 222:
            return .edRed
        case 333:
            fallthrough
        case 444:
            return .edYellow
        default:
            return .edGreen
        }
    }
}
