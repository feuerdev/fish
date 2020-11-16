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
    let aclass: String?
//    let classid: String
    let family: String?
    let familyId: Int?
    let genus: String?
//    let genusid: String
//    let is_brackish: Bool
//    let is_freshwater: Bool
//    let is_marine: Bool
//    let is_terrestrial: Bool
    let kingdom: String?
//    let kingdomid: String
    let order: String?
//    let orderid: String
    let phylum: String?
//    let phylumid: String
    let subphylum: String?
//    let subphylumid: String
    let records: Int?
    let scientificName: String?
//    let scientificNameAuthorship: String
    let species: String?
//    let speciesid: String
    let superclass: String?
    let subclass: String?
//    let subclassid: String
    let subfamily: String?
//    let subfamilyid: String
    let superfamily: String?
//    let superfamilyid: String
//    let taxonID: String
//    let taxonomicStatus: String
//    let taxonRank: String
    let category: String?
    
    static func ==(left:OBISSpecies, right:OBISSpecies) -> Bool {
        return left.familyId == right.familyId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(familyId)
    }
    
    enum CodingKeys: String, CodingKey {
        case family
        case familyId = "familyid"
        case genus
        case kingdom
        case order
        case phylum
        case subphylum
        case records
        case aclass = "class"
        case subclass
        case subfamily
        case superfamily
        case category
        case superclass
        case species
        case scientificName
        
    }
}
