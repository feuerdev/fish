//
//  PickCoordinateUseCase.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import Foundation

protocol PickCoordinateUseCaseInput {
    func search(coordinate:String)
}

protocol PickCoordinateDelegate {
    func searchSuccessful(result:[Animal])
}

class PickCoordinateUseCase {
    
    let gbifManager: GBIFManager
    var delegate: PickCoordinateDelegate?
    
    init(gbifManager: GBIFManager) {
        self.gbifManager = gbifManager
    }
}

extension PickCoordinateUseCase: PickCoordinateUseCaseInput {
    
    func search(coordinate: String) {
        gbifManager.getAnimals(coord:coordinate) {
            (result, error) -> () in
            delegate?.searchSuccessful(result: result)
        }
    }
}
