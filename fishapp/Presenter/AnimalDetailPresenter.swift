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
    var animal: Family
    
    var viewDelegate: AnimalDetailPresenterDelegate?
    var router: AnimalDetailRouter?
    
    init(animal: Family) {
        self.animal = animal
    }
    
    func presentableHierarchy() -> String {
        var result = ""
        if animal.kingdom != nil {
            result.append("> Kingdom: \(animal.kingdom!)")
        }
        if animal.phylum != nil {
            result.append("\n> Phylum: \(animal.phylum!)")
        }
        if animal.subphylum != nil {
            result.append("\n> Subphylum: \(animal.subphylum!)")
        }
        if animal.superclass != nil {
            result.append("\n> Superclass: \(animal.superclass!)")
        }
        if animal.aclass != nil {
            result.append("\n> Class: \(animal.aclass!)")
        }
        if animal.subclass != nil {
            result.append("\n> Subclass: \(animal.subclass!)")
        }
//        if animal.infraclass != nil {
//            result.append("\n> Subclass:\(animal.infraclass!)")
//        }
//        if animal.superorder != nil {
//            result.append("\n> Order\(animal.superorder!)")
//        }
        if animal.order != nil {
            result.append("\n> Order: \(animal.order!)")
        }
        if animal.family != nil {
            result.append("\n> Family: \(animal.family!)")
        }
        return result
    }
    
    func presentableDangerColor() -> String {
        return "#ffffff"
    }
    
    func presentableCategoryColor() -> String {
        switch animal.species[0].category {
        case "NT":
            return "#AAAAAA"
        default:
            return "#BBBBBB#"
        }
    }
    
    func presentableSightings() -> String {
        return "\(animal.sumRecords) Sightings"
    }
    
    func getPresentableSpeciesName(at indexPath:IndexPath) -> String {
        let species = animal.species[indexPath.row]
        return species.getPresentableName()
    }
}
