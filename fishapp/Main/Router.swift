//
//  Router.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import UIKit

class Router: PickCoordinateDelegate {
    
    var nc: UINavigationController
    var vcPickByCoord: PickByCoordinateViewController
    let gbifManager: GBIFManager
    let pickUseCase: PickCoordinateUseCase
    
    func searchSuccessful(result: [Animal]) {
        nc.pushViewController(AnimalListViewController(animals: result), animated: true)
    }
    
    init() {
        gbifManager = GBIFManager()
        pickUseCase = PickCoordinateUseCase(gbifManager: gbifManager)
        vcPickByCoord = PickByCoordinateViewController(useCaseInput: pickUseCase)
        nc = UINavigationController(rootViewController: vcPickByCoord)
        
        
        pickUseCase.delegate = self
    }
}
