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
    
    func presentableEvaluation() -> String {
        switch interactor.family.danger {
        case .edRed:
            return "Dangerous - At least one species of this family in this area has been rated dangerous"
        case .edYellow:
            return "Be Careful - At least one species of this family in this area has been rated slightly dangerous"
        case .edGreen:
            return "Harmless"
        }
    }
    
    func presentableDangerExplanation() -> String {
        return interactor.family.species.map { species -> String in
            guard let name = species.getPresentableName() else {
                return ""
            }
            
            let danger = species.dangerExplanation
            return "Species \(name):\n  \(danger)\n"
        }.reduce("") { (result, new) -> String in
            return "\(result)\(new)\n"
        }.trimmingCharacters(in: .newlines)
    }
    
    func presentableGeneralInformation() -> String {
        return
"""
Every Species is categorized into one three categories:

    Red: This animal is dangerous to humans

    Yellow: This animal could potentially harm humans, but is usually not aggressive

    Green: This animal is harmless to humans

This evaluation was made by me, the developer of the app. I'm not an expert so use this information with caution. If you think a category is wrong or you have other improvement suggestions, please send me an email at jannik@feuer.dev
"""
    }
    
    func presentableSpeciesName(at indexPath:IndexPath) -> String? {
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
