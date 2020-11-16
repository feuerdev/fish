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
    
    var animals = [Family]()
    
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
                self.animals = self.getFamilies(result)
                self.presenterDelegate?.loadAnimalsSuccess()
                
                self.loadVernaculars()
//                self.loadImages()
                
            case .failure(let error):
                self.presenterDelegate?.loadAnimalsFailure(error: error.localizedDescription)
            }
        }
    }
    
    func loadVernaculars() {
        DispatchQueue.global(qos: .userInitiated).async {
            for family in self.animals {
                WORMSService.getVernacular(id: family.familyId) { result in
                    switch result {
                    case .success(let name):
                        family.vernacular = name
                        self.presenterDelegate?.refreshAnimal(animal: family)
                    case .failure(_):
                        break
                        //Nothing to do
                    }
                }
            }
        }
    }
    
    func getFamilies(_ species:OBISResponse) -> [Family] {
        var families = [Family]()
        for species in species.results {
            guard species.familyId != nil else {
                continue
            }
            var alreadyAdded = false
            for fam in families {
                if species.familyId == fam.familyId {
                    if let name = species.species ?? species.scientificName {
                        fam.species.append(name)
                    }
                    alreadyAdded = true
                    break
                }
            }
            if !alreadyAdded {
                if let familyId = species.familyId {
                    let new = Family(familyId)
                    new.family = species.family
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
                    new.risk = self.getRisk(familyId)
                    families.append(new)
                }
            }
        }
        return families
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
