//
//  Species.swift
//  big-pond
//
//  Created by Jannik Feuerhahn on 12.01.21.
//

import Foundation

class Species {
    var taxonId: Int
    var kingdomId: Int?
    var phylumId: Int?
    var subphylumId: Int?
    var superclassId: Int?
    var aclassId: Int?
    var subclassId: Int?
    var orderId: Int?
    var superfamilyId: Int?
    var familyId: Int?
    var genusId: Int?

    var kingdom: String?
    var phylum: String?
    var subphylum: String?
    var superclass: String?
    var aclass: String?
    var subclass: String?
    var order: String?
    var superfamily: String?
    var family: String?
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
    var danger: Danger = .edGreen
    var dangerExplanation: String = "This species is harmless"

    init(_ taxonId: Int) {
        self.taxonId = taxonId
    }
}
