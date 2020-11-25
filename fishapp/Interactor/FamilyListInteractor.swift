//
//  AnimalListInteractor.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

protocol FamilyListInteractorDelegate {
    func loadAnimalsSuccess()
    func loadAnimalsFailure(error: String)
    func loadAnimalsStatusUpdate(status: String)
    func refreshAnimal(animal:Family)
}

class FamilyListInteractor {
    
    var animals = [Family]()
    
    var location: Location?
    
    var presenterDelegate: FamilyListInteractorDelegate?
    
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
        }) { result in
            switch result {
            case .success(let result):
                self.animals = self.getFamilies(result)
                self.presenterDelegate?.loadAnimalsStatusUpdate(status: "Found \(self.animals.count) Animals")
                var photosLoaded = 0
                var namesLoaded = 0
                let group = DispatchGroup()
                
                func loadingString() -> String {
                    return "Loading Photos: \(photosLoaded)/\(self.animals.count)\nLoading Vernaculars: \(namesLoaded)/\(self.animals.count)"
    }
    
        for family in self.animals {
                    //Photos
            if let param = family.family {
                        group.enter()
                LoadPhotoService.loadPhoto(id: String(family.familyId), searchParameter: param) { result in
                    switch result {
                    case .success(let url):
                        family.photoFileName = url
                    case .failure(_):
                        family.noPhoto = true
                    }
                            photosLoaded += 1
                            self.presenterDelegate?.loadAnimalsStatusUpdate(status: loadingString())
                            group.leave()
                }
            }
    
                    //Vernaculars
                    group.enter()
                    LoadVernacularService.loadVernacular(id: family.familyId) { result in
                    switch result {
                    case .success(let name):
                        family.vernacular = name
                    case .failure(_):
                        break
                        }
                        namesLoaded += 1
                        self.presenterDelegate?.loadAnimalsStatusUpdate(status: loadingString())
                        group.leave()
                    }
                }
                group.notify(queue: DispatchQueue.main) {
                    self.presenterDelegate?.loadAnimalsSuccess()
                }
                
            case .failure(let error):
                self.presenterDelegate?.loadAnimalsFailure(error: error.localizedDescription)
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
                    new.genus = species.genus
                    new.kingdom = species.genus
                    new.phylum = species.phylum
                    new.subphylum = species.subphylum
                    new.superclass = species.superclass
                    new.aclass = species.aclass
                    new.subclass = species.subclass
                    new.order = species.order
                    new.subfamily = species.subfamily
                    new.superfamily = species.superfamily
                    new.vernacular = nil
                    new.risk = self.getRisk(familyId)
                    
                    let newSpecies = createSpecies(from: species)
                    if let records = newSpecies.records {
                        new.sumRecords += records
                    }
                    new.species.append(newSpecies)
                    families.append(new)
                }
            }
        }
        return families
    }
    
    func createSpecies(from species:OBISSpecies) -> Species {
        let new = Species(species.taxonID)
        new.category = species.category
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
