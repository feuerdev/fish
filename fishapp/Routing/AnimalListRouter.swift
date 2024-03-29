//
//  AnimalListViewRouter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation
import UIKit

class AnimalListRouter {

    static func createModule(location: Location) -> UIViewController {
        let vc = FamilyListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

        let presenter = FamilyListPresenter()
        let interactor = FamilyListInteractor()
        let router = AnimalListRouter()

        vc.presenter = presenter
        presenter.router = router
        presenter.viewDelegate = vc
        presenter.interactor = interactor
        interactor.location = location
        interactor.presenterDelegate = presenter

        return vc
    }

    func pushToAnimalDetailView(view: AnimalListPresenterDelegate, with animal: Family) {
        let newVC = AnimalDetailRouter.createModule(animal: animal)

        let oldVC = view as! UIViewController
        oldVC.navigationController?.pushViewController(newVC, animated: true)
    }
}
