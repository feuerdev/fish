//
//  OBISResponse.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 29.10.20.
//

import Foundation

struct OBISResponse: Decodable {
    let results: [OBISSpecies]
    let total: Int
}

struct OBISSpecies: Decodable, Hashable, Equatable {
//    let acceptedNameUsage: String
//    let acceptedNameUsageID: String
//    //let class: String
//    let classid: String
    let family: String?
    let familyid: Int?
//    let genus: String
//    let genusid: String
//    let is_brackish: Bool
//    let is_freshwater: Bool
//    let is_marine: Bool
//    let is_terrestrial: Bool
//    let kingdom: String
//    let kingdomid: String
//    let order: String
//    let orderid: String
//    let phylum: String
//    let phylumid: String
//    let records: Int
//    let scientificName: String
//    let scientificNameAuthorship: String
//    let species: String
//    let speciesid: String
//    let subclass: String
//    let subclassid: String
//    let subfamily: String
//    let subfamilyid: String
//    let superfamily: String
//    let superfamilyid: String
//    let taxonID: String
//    let taxonomicStatus: String
//    let taxonRank: String
    
    static func ==(left:OBISSpecies, right:OBISSpecies) -> Bool {
        return left.familyid == right.familyid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(familyid)
    }
}
