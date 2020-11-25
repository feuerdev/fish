//
//  AnimalListPresenter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

protocol AnimalListPresenterDelegate {
    func updateLoadingStatus(status: String) -> Void
    func refreshCells()
    func refreshCell(indexPath: IndexPath)
    func hideLoadingView()
    func showError(_ error:String)
}

class FamilyListPresenter {
    
    var interactor: FamilyListInteractor?
    var router: AnimalListRouter?
    var viewDelegate: AnimalListPresenterDelegate?
    
    func viewDidLoad() {
        interactor?.loadAnimals()
    }
    
    func didSelectRowAt(_ indexPath:IndexPath) {
        if let animal = interactor?.animals[indexPath.row] {
            router?.pushToAnimalDetailView(view: viewDelegate!, with: animal)
        }
    }
}

extension FamilyListPresenter: FamilyListInteractorDelegate {
    func refreshAnimal(animal: Family) {
        DispatchQueue.main.async {
            if let index = self.interactor?.animals.firstIndex(where: {$0 === animal}) {
                self.viewDelegate?.refreshCell(indexPath: IndexPath(row: index, section: 0))
            }
        }
    }
    
    func loadAnimalsSuccess() {
        DispatchQueue.main.async {
            self.viewDelegate?.refreshCells()
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


