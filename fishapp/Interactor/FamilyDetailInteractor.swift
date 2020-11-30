//
//  AnimalDetailInteractor.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 22.11.20.
//

import Foundation

protocol FamilyDetailInteractorDelegate {
    func refreshSpecies(species: Species)
}

class FamilyDetailInteractor {
    
    init(family: Family) {
        self.family = family
    }
    
    let family: Family
    var presenterDelegate: FamilyDetailInteractorDelegate?
    
    func loadSpecies() {
        for species in family.species {
            LoadPhotoService.loadPhoto(id: species.taxonId, searchParameter: species.getPresentableName()) { result in
                switch result {
                case .success(let result):
                    species.photoFileName = result.url
                case .failure(_):
                    species.noPhoto = true
                }
                self.presenterDelegate?.refreshSpecies(species: species)
            }
        }
    }
}
