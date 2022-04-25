//
//  GBIFResponse.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 22.10.20.
//

import Foundation

struct GBIFResponse: Decodable {

    let offset: Int
    let limit: Int
    let endOfRecords: Bool
    let count: Int

    let results: [GBIFOccurrence]
}

struct GBIFOccurrence: Decodable, Hashable, Equatable {
    let key: Int
    let taxonRank: String
    let taxonKey: Int
    let kingdomKey: Int
    let phylumKey: Int
    let classKey: Int
    let orderKey: Int
    let familyKey: Int
    let genusKey: Int
    let speciesKey: Int
    let acceptedTaxonKey: Int
    let scientificName: String
    let genericName: String
    let specificEpithet: String
    let vernacularName: String
    let occurrenceID: String

    static func ==(left: GBIFOccurrence, right: GBIFOccurrence) -> Bool {
        return left.familyKey == right.familyKey
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(familyKey)
    }

}
