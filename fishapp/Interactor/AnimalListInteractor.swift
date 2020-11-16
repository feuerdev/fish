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
                self.loadPhotos()
                
            case .failure(let error):
                self.presenterDelegate?.loadAnimalsFailure(error: error.localizedDescription)
            }
        }
    }
    
    func loadPhotos() {
        DispatchQueue.global(qos: .userInitiated).async {
            for family in self.animals {
                //Step 1: Check in UserDefaults for Image
                if let fileName = UserDefaults.standard.string(forKey: String(family.familyId)) {
                    //Step 2: Check if family doesn't have photo
                    if fileName == FAMILY_NO_PHOTO {
                        family.noPhoto = true
                        self.presenterDelegate?.refreshAnimal(animal: family)
                    } else {
                        family.photoFileName = fileName
                        self.presenterDelegate?.refreshAnimal(animal: family)
                    }
                } else {
                    //Step 4: Never looked for Photo. Ask Wiki for it.
                    if let name = family.family {
                        WikiPhotoURLService.getPhotoUrl(scientificName: name, completionHandler: { result in
                            switch result {
                            case .failure(let error):
                                if error as! ServiceError == ServiceError.noData {
                                    UserDefaults.standard.setValue(FAMILY_NO_PHOTO, forKey: String(family.familyId))
                                    family.noPhoto = true
                                    self.presenterDelegate?.refreshAnimal(animal: family)
                                }
                                print("'\(name)' encountered error: \(error)")
                            case .success(let url):
                                //Step 5: Download and save the photo in Documents
                                if let url = URL(string: url) {
                                    if let data = try? Data(contentsOf: url) {
                                        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                                        let fileUrl = documents.appendingPathComponent(url.lastPathComponent)
                                        do {
                                            try data.write(to: fileUrl)
                                            UserDefaults.standard.setValue(fileUrl.lastPathComponent, forKey: String(family.familyId))
                                            family.photoFileName = fileUrl.lastPathComponent
                                            self.presenterDelegate?.refreshAnimal(animal: family)
                                        } catch(let error) {
                                            print(error)
                                        }
                                    }
                                }
                            }
                        })
                    }
                }
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
