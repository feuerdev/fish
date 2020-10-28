//
//  AnimalListInteractor.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

protocol AnimalListInteractorDelegate {
    func loadAnimalsSuccess(animals: [Animal])
    func loadAnimalsFailure(error: LocalizedError)
    func loadAnimalsStatusUpdate(status: String)
}

class AnimalListInteractor {
    
    var location: Location?
    
    var presenterDelegate: AnimalListInteractorDelegate?
    
    func loadAnimals() {
        presenterDelegate?.loadAnimalsFailure(error: MyError("Noob"))
//        OBISService.loadAnimals(location: location, delegate: self)
    }
}

class MyError: LocalizedError {
    
    var failureReason: String?
    init(_ reason:String) {
        failureReason = reason
    }
    
}

//extension AnimalListInteractor: OBISServiceDelegate {
//
//}
