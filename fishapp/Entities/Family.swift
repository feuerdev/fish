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

class Species {
    var taxonId: Int
    var genus: String?
    var species: String?
    var taxonRank: String?
    var taxonomicStatus: String?
    var authorship: String?
    var category: String?
    var isMarine: Bool?
    var isBrackish: Bool?
    var isFreshwater: Bool?
    var isTerrestrial: Bool?
    var records: Int?
    
    init(_ taxonId: Int) {
        self.taxonId = taxonId
    }
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
    var sumRecords: Int = 0
    var subfamily: String?
    var superfamily: String?
    var vernacular: String?
    var risk: Risk?
    var species: [Species] = []
    
    var noPhoto: Bool = false
    var photoFileName: String?
    
    init(_ familyId: Int) {
        self.familyId = familyId
    }
}
