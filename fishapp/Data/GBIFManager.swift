//
//  GBIFManager.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import Foundation

class GBIFError: Error {
    
}

class GBIFManager {
    
    func getAnimals(coord:String, result: ([Animal], GBIFError) -> ()) -> Void {
        
        result([Animal(family: "Delphin", category: .edGreen), Animal(family: "Hai", category: .edRed)], GBIFError())
        
    }
    
}
