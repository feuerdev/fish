//
//  AnimalDetailRouter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import UIKit

class AnimalDetailRouter {
    
    static func createModule(animal: Family) -> UIViewController {
        let tbc = UITabBarController()
        
        //Photo and Wiki Info
        let vc1 = FamilyDetailInformationViewController()
        vc1.tabBarItem.title = "Information"
        vc1.tabBarItem.image = UIImage(named: "whale20")
        
        //Species List
        let vc2 = FamilyDetailSpeciesListTableViewController()
        vc2.tabBarItem.title = "Species"
        vc2.tabBarItem.image = UIImage(named: "whale20")
        
        //Danger Info
        let vc3 = FamilyDetailDangerViewController()
        vc3.tabBarItem.title = "Danger"
        vc3.tabBarItem.image = UIImage(named: "whale20")
        
        //Taxonomy
        let vc4 = FamilyDetailTaxonomyViewController()
        vc4.tabBarItem.title = "Taxonomy"
        vc4.tabBarItem.image = UIImage(named: "whale20")
        
        tbc.viewControllers = [vc1, vc2, vc3, vc4]
        
        return tbc
        
        //
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
