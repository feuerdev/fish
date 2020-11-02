//
//  AnimalListInteractor.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

protocol AnimalListInteractorDelegate {
    func loadAnimalsSuccess(animals: [Animal])
    func loadAnimalsFailure(error: String)
    func loadAnimalsStatusUpdate(status: String)
}

class AnimalListInteractor {
    
    var location: Location?
    
    var presenterDelegate: AnimalListInteractorDelegate?
    
    func loadAnimals() {
        let service = OBISService()
        service.getChecklist(location:location!, delegate:self)
    }
}

extension AnimalListInteractor: OBISServiceDelegate {
    func didSuccessfullyReturn(_ animals: [Animal]) {
        presenterDelegate?.loadAnimalsSuccess(animals: animals)
    }
    
    func didFailWithError(_ error: String) {
        presenterDelegate?.loadAnimalsFailure(error: error)
    }
    
    func updateStatus(_ status: String) {
        presenterDelegate?.loadAnimalsStatusUpdate(status: status)
    }
    

}
