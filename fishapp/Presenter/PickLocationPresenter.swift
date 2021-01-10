//
//  PickLocationPresenter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation

protocol PickLocationPresenterDelegate: AnyObject {
    //
}

class PickLocationPresenter {
    
    var router: PickLocationRouter?
    
    weak var viewDelegate: PickLocationPresenterDelegate?
    
    func search(view: PickLocationPresenterDelegate, location: Location) -> Void {
        router?.pushToAnimalListView(view: view, with: location)
    }
}
