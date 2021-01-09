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
        
        let interactor = FamilyDetailInteractor(family: animal)
        let presenter = FamilyDetailPresenter(interactor: interactor)
        interactor.presenterDelegate = presenter
        
        //Photo and Wiki Info
        let vc1 = FamilyDetailInformationViewController()
        vc1.tabBarItem.title = "Information"
        vc1.tabBarItem.image = UIImage(named: "whale20")
        vc1.presenter = presenter
        presenter.viewDelegate = vc1
        
        //Species List
        let vc2 = FamilyDetailSpeciesListTableViewController()
        vc2.tabBarItem.title = "Species"
        vc2.tabBarItem.image = UIImage(named: "whale20")
        vc2.presenter = presenter
        
        //Danger Info
        let vc3 = FamilyDetailDangerViewController()
        vc3.tabBarItem.title = "Danger"
        vc3.tabBarItem.image = UIImage(named: "whale20")
        vc3.presenter = presenter
        
        //Taxonomy
        let vc4 = FamilyDetailTaxonomyViewController()
        vc4.tabBarItem.title = "Taxonomy"
        vc4.tabBarItem.image = UIImage(named: "whale20")
        vc4.presenter = presenter
        
        tbc.viewControllers = [vc1, vc2, vc3, vc4]
        
        return tbc
    }
}
