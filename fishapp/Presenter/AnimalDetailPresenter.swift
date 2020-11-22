//
//  AnimalDetailPresenter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 04.11.20.
//

import Foundation

protocol AnimalDetailPresenterDelegate {
    func refreshCell(indexPath: IndexPath)
}

class AnimalDetailPresenter {
    
    var interactor: AnimalDetailInteractor
    var viewDelegate: AnimalDetailPresenterDelegate?
    var router: AnimalDetailRouter?
    
    init(interactor: AnimalDetailInteractor) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        self.interactor.loadSpecies()
    }
    
    func presentableHierarchy() -> String {
        var result = ""
        if interactor.family.kingdom != nil {
            result.append("> Kingdom: \(interactor.family.kingdom!)")
        }
        if interactor.family.phylum != nil {
            result.append("\n> Phylum: \(interactor.family.phylum!)")
        }
        if interactor.family.subphylum != nil {
            result.append("\n> Subphylum: \(interactor.family.subphylum!)")
        }
        if interactor.family.superclass != nil {
            result.append("\n> Superclass: \(interactor.family.superclass!)")
        }
        if interactor.family.aclass != nil {
            result.append("\n> Class: \(interactor.family.aclass!)")
        }
        if interactor.family.subclass != nil {
            result.append("\n> Subclass: \(interactor.family.subclass!)")
        }
        //        if animal.infraclass != nil {
        //            result.append("\n> Subclass:\(animal.infraclass!)")
        //        }
        //        if animal.superorder != nil {
        //            result.append("\n> Order\(animal.superorder!)")
        //        }
        if interactor.family.order != nil {
            result.append("\n> Order: \(interactor.family.order!)")
        }
        if interactor.family.family != nil {
            result.append("\n> Family: \(interactor.family.family!)")
        }
        return result
    }
    
    func presentableSightings() -> String {
        return "\(interactor.family.sumRecords) Sightings"
    }
    
    func getPresentableSpeciesName(at indexPath:IndexPath) -> String {
        return interactor.family.species[indexPath.row].getPresentableName()
    }
}

extension AnimalDetailPresenter: AnimalDetailInteractorDelegate {
    func refreshSpecies(species: Species) {
        DispatchQueue.main.async {
            if let index = self.interactor.family.species.firstIndex(where: {$0 === species}) {
                self.viewDelegate?.refreshCell(indexPath: IndexPath(row: index, section: 0))
            }
        }
    }
}
