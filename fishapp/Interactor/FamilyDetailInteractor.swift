//
//  AnimalDetailInteractor.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 22.11.20.
//

import UIKit

protocol FamilyDetailInteractorDelegate {
    func photoLoaded(_ photo:UIImage?)
    func vernacularLoaded(_ vernacular:String?)
    func descriptionLoaded(_ description:String?)
}

class FamilyDetailInteractor {
    
    let family: Family
    var presenterDelegate: FamilyDetailInteractorDelegate?
    
    init(family: Family) {
        self.family = family
    }
    
    func loadPhoto() {
        LoadPhotoService.loadPhoto(id: family.familyId, searchParameters: family.generatePhotoSearchterms()) { [weak self] result in
            switch result.result {
            case .success(let image):
                self?.presenterDelegate?.photoLoaded(image)
            case .failure(_):
                self?.presenterDelegate?.photoLoaded(nil)
            }
        }
    }
    
    func loadVernacular() {
        LoadVernacularService.loadVernacular(id: family.familyId) { [weak self] result in
            switch result.result {
            case .success(let vernacular):
                self?.presenterDelegate?.vernacularLoaded(vernacular)
            case .failure(_):
                self?.presenterDelegate?.vernacularLoaded(nil)
            }
        }
    }
    
    func loadDescription() {
        if let searchTerm = family.family {
            LoadDescriptionService.loadDescription(id: family.familyId, searchTerm: searchTerm) { [weak self] result in
                switch result {
                case .success(let description):
                    self?.presenterDelegate?.descriptionLoaded(description)
                case .failure(_):
                    self?.presenterDelegate?.descriptionLoaded(nil)
                }
            }
        } else {
            self.presenterDelegate?.descriptionLoaded(nil)
        }
    }
    
}
