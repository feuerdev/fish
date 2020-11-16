//
//  Family.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import Foundation

enum Risk {
    case edGreen, edYellow, edRed
}

class Family {
    let familyId: Int
    
    var family: String?
    var genus: String?
    var kingdom: String?
    var phylum: String?
    var subphylum: String?
    var superclass: String?
    var aclass: String?
    var subclass: String?
    var order: String?
    var records: Int?
    var subfamily: String?
    var superfamily: String?
    var category: String?
    var vernacular: String?
    var risk: Risk?
    var species: [String] = []
    
    var noPhoto: Bool = false
    var photoFileName: String?
    
    init(_ familyId: Int) {
        self.familyId = familyId
    }
}
