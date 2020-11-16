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
    
    var interactor: AnimalListInteractor?
    var router: AnimalListRouter?
    var viewDelegate: AnimalListPresenterDelegate?
    
    func viewDidLoad() {
        interactor?.loadAnimals()
    }
    
    func didSelectRowAt(_ indexPath:IndexPath) {
        if let animal = interactor?.animals![indexPath.row] {
            router?.pushToAnimalDetailView(view: viewDelegate!, with: animal)
        }
    }
}

extension AnimalListPresenter: AnimalListInteractorDelegate {
    func refreshAnimal(animal: Family) {
        self.viewDelegate?.refreshData() //TODO: Only refresh relevant cell, also make the presenter get the correct index?
    }
    
    func loadAnimalsSuccess() {
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


