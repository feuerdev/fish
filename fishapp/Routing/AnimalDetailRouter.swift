//
//  AnimalDetailRouter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

class AnimalDetailRouter {
    
    static func createModule(animal: Family) -> FamilyDetailViewController {
        let vc = FamilyDetailViewController()
        
        let interactor = FamilyDetailInteractor(family: animal)
        let presenter = FamilyDetailPresenter(interactor: interactor)
        let router = AnimalDetailRouter()

        interactor.presenterDelegate = presenter
        vc.presenter = presenter
        presenter.router = router
        presenter.viewDelegate = vc
        
        return vc
    }
    
    func pushToAnimalDetailView(view: AnimalListPresenterDelegate, with animal:Family) {
        let newVC = AnimalDetailRouter.createModule(animal: animal)
        
        let oldVC = view as! FamilyListCollectionViewController
        oldVC.navigationController?.pushViewController(newVC, animated: true)
    }
}
