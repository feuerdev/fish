//
//  AnimalDetailInteractor.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 22.11.20.
//

import Foundation

protocol FamilyDetailInteractorDelegate {
    //
}

class FamilyDetailInteractor {
    
    init(family: Family) {
        self.family = family
    }
    
    let family: Family
    var presenterDelegate: FamilyDetailInteractorDelegate?
}
