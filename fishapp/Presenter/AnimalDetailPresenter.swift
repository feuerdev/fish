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
}
