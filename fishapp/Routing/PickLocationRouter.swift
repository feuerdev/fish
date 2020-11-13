//
//  PickCoordinateRouter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 26.10.20.
//

import UIKit

class PickLocationRouter {
    
    static func createModule() -> UINavigationController {
        let vc = PickLocationViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationBar.isTranslucent = false
    
        let presenter = PickLocationPresenter()
        let router = PickLocationRouter()
        
        vc.presenter = presenter
        vc.presenter?.router = router
        
        return nc
    }
    
    func pushToAnimalListView(view: PickLocationPresenterDelegate, with location:Location) {
        let newVC = AnimalListRouter.createModule(location: location)
        
        let oldVC = view as! PickLocationViewController
        oldVC.navigationController?.pushViewController(newVC, animated: true)
    }
}
