//
//  AnimalListPresenter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

protocol AnimalListPresenterDelegate {
    func updateLoadingStatus(status: String) -> Void
    func refreshData()
    func hideLoadingView()
    func showError(_ error:String)
}

class AnimalListPresenter {
    
    var animals: [Animal]?
    
    var interactor: AnimalListInteractor?
    var router: AnimalListRouter?
    var viewDelegate: AnimalListPresenterDelegate?
    
    func viewDidLoad() {
        interactor?.loadAnimals()
    }
}

extension AnimalListPresenter: AnimalListInteractorDelegate {
    func loadAnimalsSuccess(animals: [Animal]) {
        self.animals = animals
        
        DispatchQueue.main.async {
            self.viewDelegate?.refreshData()
            self.viewDelegate?.hideLoadingView()
        }
    }
    
    func loadAnimalsFailure(error: String) {
        DispatchQueue.main.async {
            self.viewDelegate?.showError(error)
        }
    }
    
    func loadAnimalsStatusUpdate(status: String) {
        DispatchQueue.main.async {
            self.viewDelegate?.updateLoadingStatus(status: status)
        }
    }
    
    
}


