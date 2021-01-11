//
//  AnimalListInteractor.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

protocol FamilyListInteractorDelegate: AnyObject {
    func loadAnimalsSuccess()
    func loadAnimalsFailure(error: String)
    func loadAnimalsStatusUpdate(status: String)
    func loadAnimalsStatusUpdate(percent: Float)
}

class FamilyListInteractor {
    
    var animals = [Family]()
    
    var location: Location?
    
    weak var presenterDelegate: FamilyListInteractorDelegate?
    
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
        
        OBISService.getCheckList(location: location, onStatus: {_ in
            self.presenterDelegate?.loadAnimalsStatusUpdate(status: "Searching Animals...")
            self.presenterDelegate?.loadAnimalsStatusUpdate(percent: 0.05)
        }) { result in
            switch result {
            case .success(let result):
                self.animals = self.createFamilies(result)
                self.presenterDelegate?.loadAnimalsStatusUpdate(status: "Found \(self.animals.count) Animals")
                self.presenterDelegate?.loadAnimalsStatusUpdate(percent: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.presenterDelegate?.loadAnimalsSuccess()
                }
            case .failure(let error):
                self.presenterDelegate?.loadAnimalsFailure(error: error.localizedDescription)
            }
        }
    }
    
    func createFamilies(_ species:OBISResponse) -> [Family] {
        var families = [Family]()
        for species in species.results {
            guard species.familyId != nil else {
                continue
            }
            
            if(!self.filter(species)) {
                var alreadyAdded = false
                for fam in families {
                    if species.familyId == fam.familyId {
                        let new = createSpecies(from: species)
                        fam.species.append(new)
                        if let records = new.records {
                            fam.sumRecords += records
                        }
                        alreadyAdded = true
                        break
                    }
                }
                if !alreadyAdded {
                    if let familyId = species.familyId {
                        let new = Family(familyId)
                        new.family = species.family
                        new.kingdom = species.genus
                        new.phylum = species.phylum
                        new.subphylum = species.subphylum
                        new.superclass = species.superclass
                        new.aclass = species.aclass
                        new.subclass = species.subclass
                        new.order = species.order
                        new.superfamily = species.superfamily
                        
                        let newSpecies = createSpecies(from: species)
                        if let records = newSpecies.records {
                            new.sumRecords += records
                        }
                        new.species.append(newSpecies)
                        families.append(new)
                    }
                }
            }
        }
        evaluateDanger(families)
        return families
    }
    
    func filter(_ species:OBISSpecies) -> Bool {
        let relevantIds = [species.kingdomId,
                           species.phylumId,
                           species.subphylumId,
                           species.superclassId,
                           species.aclassId,
                           species.subclassId,
                           species.orderId,
                           species.superfamilyId,
                           species.familyId,
                           species.genusId,
                           species.taxonID]
        
        for speciesId in relevantIds {
            for filterId in filteredSpecies {
                if speciesId == filterId {
                    return true
                }
            }
        }
        return false
    }
    
    func createSpecies(from species:OBISSpecies) -> Species {
        let new = Species(species.taxonID)
        new.category = species.category
        
        new.kingdomId = species.kingdomId
        new.phylumId = species.phylumId
        new.subphylumId = species.subphylumId
        new.superclassId = species.superclassId
        new.aclassId = species.aclassId
        new.subclassId = species.subclassId
        new.orderId = species.orderId
        new.superfamilyId = species.superfamilyId
        new.familyId = species.familyId
        new.genusId = species.genusId
        
        new.kingdom = species.kingdom
        new.phylum = species.phylum
        new.subphylum = species.subphylum
        new.superclass = species.superclass
        new.aclass = species.aclass
        new.subclass = species.subclass
        new.order = species.order
        new.superfamily = species.superfamily
        new.family = species.family
        new.genus = species.genus
        new.species = species.species
        new.taxonRank = species.taxonRank
        new.taxonomicStatus = species.taxonomicStatus
        new.authorship = species.scientificNameAuthorship
        new.category = species.category
        new.isMarine = species.is_marine
        new.isBrackish = species.is_brackish
        new.isFreshwater = species.is_freshwater
        new.isTerrestrial = species.is_terrestrial
        new.records = species.records
        return new
    }
    
    func evaluateDanger(_ families:[Family]) {
        for family in families {
            for species in family.species {
                
                //relevantId's are in order of specificity
                let relevantIds = [
                    species.taxonId,
                    species.genusId,
                    species.familyId,
                    species.superfamilyId,
                    species.orderId,
                    species.subclassId,
                    species.aclassId,
                    species.superclassId,
                    species.subphylumId,
                    species.phylumId]
                
                for id in relevantIds {
                    if let id = id,
                       let classification = Classification.data[id] {
                        species.danger = classification.danger
                        species.dangerExplanation = classification.explanation
                        break
                    }
                }
            }
        }
    }
}
