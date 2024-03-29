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
    let error: String?
}

struct OBISSpecies: Decodable, Hashable, Equatable {

    let kingdomId: Int?
    let phylumId: Int?
    let subphylumId: Int?
    let superclassId: Int?
    let aclassId: Int?
    let subclassId: Int?
    let orderId: Int?
    let superfamilyId: Int?
    let familyId: Int?
    let genusId: Int?

    let aclass: String?
    let family: String?
    let genus: String?
    let isBrackish: Bool?
    let isFreshwater: Bool?
    let isMarine: Bool?
    let isTerrestrial: Bool?
    let kingdom: String?
    let order: String?
    let phylum: String?
    let subphylum: String?
    let records: Int?
    let scientificName: String?
    let scientificNameAuthorship: String?
    let species: String?
    let superclass: String?
    let subclass: String?
    let subfamily: String?
    let superfamily: String?
    let taxonID: Int
    let taxonomicStatus: String?
    let taxonRank: String?
    let category: String?

    static func ==(left: OBISSpecies, right: OBISSpecies) -> Bool {
        return left.familyId == right.familyId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(familyId)
    }

    enum CodingKeys: String, CodingKey {
        case family
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
        case scientificNameAuthorship
        case isBrackish = "is_brackish"
        case isFreshwater = "is_freshwater"
        case isMarine = "is_marine"
        case isTerrestrial = "is_terrestrial"
        case taxonID
        case taxonRank
        case taxonomicStatus
        case kingdomId = "kingdomid"
        case phylumId = "phylumid"
        case subphylumId = "subphylumid"
        case superclassId = "superclassid"
        case aclassId = "classid"
        case subclassId = "subclassid"
        case orderId = "orderid"
        case superfamilyId = "superfamilyid"
        case familyId = "familyid"
        case genusId = "genusid"
    }
}
