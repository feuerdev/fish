//
//  AnimalDetailPresenter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 04.11.20.
//

import Foundation

protocol AnimalDetailPresenterDelegate {
    //
}

class AnimalDetailPresenter {
    var animal: Animal
    
    var viewDelegate: AnimalDetailPresenterDelegate?
    var router: AnimalDetailRouter?
    
    init(animal: Animal) {
        self.animal = animal
    }
    
    func presentableHierarchy() -> String {
        var result = ""
        if animal.kingdom != nil {
            result.append(">\(animal.kingdom!)")
        }
        if animal.phylum != nil {
            result.append("\n>\(animal.phylum!)")
        }
        if animal.subphylum != nil {
            result.append("\n>\(animal.subphylum!)")
        }
        if animal.superclass != nil {
            result.append("\n>\(animal.superclass!)")
        }
        if animal.aclass != nil {
            result.append("\n>\(animal.aclass!)")
        }
        if animal.order != nil {
            result.append("\n>\(animal.order!)")
        }
        if animal.order != nil {
            result.append("\n>\(animal.order!)")
        }
        if animal.family != nil {
            result.append("\n>\(animal.family!)")
        }
        return result
    }
    
    func presentableDangerColor() -> String {
        return "#ffffff"
    }
    
    func presentableCategory() -> String {
        switch animal.category {
        case "NT":
            return "Not Threatened"
        default:
            return ""
        }
    }
    
    func presentableCategoryColor() -> String {
        switch animal.category {
        case "NT":
            return "#AAAAAA"
        default:
            return "#BBBBBB#"
        }
    }
    
    func presentableSightings() -> String {
        return "\(animal.records!) Sightings"
    }
}
