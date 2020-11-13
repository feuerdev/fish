//
//  AnimalDetailRouter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

class AnimalDetailRouter {
    
    static func createModule(animal: Animal) -> AnimalDetailViewController {
        let vc = AnimalDetailViewController()
        
        let presenter = AnimalDetailPresenter(animal: animal)
        let router = AnimalDetailRouter()

        vc.presenter = presenter
        presenter.router = router
        presenter.viewDelegate = vc
        
        return vc
    }
    
    func pushToAnimalDetailView(view: AnimalListPresenterDelegate, with animal:Animal) {
        let newVC = AnimalDetailRouter.createModule(animal: animal)
        
        let oldVC = view as! AnimalListViewController
        oldVC.navigationController?.pushViewController(newVC, animated: true)
    }
}