//
//  AnimalDetailPresenter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 04.11.20.
//

import UIKit

protocol FamilyDetailPresenterDelegate: AnyObject {
    func photoLoaded(_ photo:UIImage?)
    func vernacularLoaded(_ vernacular:String?)
    func descriptionLoaded(_ description:String?)
}

class FamilyDetailPresenter {
    
    var interactor: FamilyDetailInteractor
    weak var viewDelegate: FamilyDetailPresenterDelegate?
    
    init(interactor: FamilyDetailInteractor) {
        self.interactor = interactor
    }
    
    func loadPhoto() {
        interactor.loadPhoto()
    }
    
    func loadVernacular() {
        interactor.loadVernacular()
    }
    
    func loadDescription() {
        interactor.loadDescription()
    }
    
    func presentableHierarchy() -> String {
        var result = ""
        if interactor.family.kingdom != nil {
            result.append("▼Kingdom: \(interactor.family.kingdom!)▼")
        }
        if interactor.family.phylum != nil {
            result.append("\n▼Phylum: \(interactor.family.phylum!)▼")
        }
        if interactor.family.subphylum != nil {
            result.append("\n▼Subphylum: \(interactor.family.subphylum!)▼")
        }
        if interactor.family.superclass != nil {
            result.append("\n▼Superclass: \(interactor.family.superclass!)▼")
        }
        if interactor.family.aclass != nil {
            result.append("\n▼Class: \(interactor.family.aclass!)▼")
        }
        if interactor.family.subclass != nil {
            result.append("\n▼Subclass: \(interactor.family.subclass!)▼")
        }
        //        if animal.infraclass != nil {
        //            result.append("\n> Subclass:\(animal.infraclass!)")
        //        }
        //        if animal.superorder != nil {
        //            result.append("\n> Order\(animal.superorder!)")
        //        }
        if interactor.family.order != nil {
            result.append("\n▼Order: \(interactor.family.order!)▼")
        }
        if interactor.family.family != nil {
            result.append("\n▼Family: \(interactor.family.family!)▼")
        }
        return result
    }
    
    func getPresentableSpeciesName(at indexPath:IndexPath) -> String {
        return interactor.family.species[indexPath.row].getPresentableName()
    }
}

extension FamilyDetailPresenter: FamilyDetailInteractorDelegate {
    func photoLoaded(_ photo: UIImage?) {
        viewDelegate?.photoLoaded(photo)
    }
    
    func vernacularLoaded(_ vernacular: String?) {
        viewDelegate?.vernacularLoaded(vernacular)
    }
    
    func descriptionLoaded(_ description: String?) {
        viewDelegate?.descriptionLoaded(description)
    }
}
