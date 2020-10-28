//
//  AnimalListViewRouter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

class AnimalListRouter {
    
    static func createModule(location: Location) -> AnimalListViewController {
        let vc = AnimalListViewController()
        
        let presenter = AnimalListPresenter()
        let interactor = AnimalListInteractor()
        let router = AnimalListRouter()

        vc.presenter = presenter
        presenter.router = router
        presenter.viewDelegate = vc
        presenter.interactor = interactor
        interactor.location = location
        interactor.presenterDelegate = presenter
        
        return vc
    }
}
