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
    var vernacular: String?
    
    init(_ taxonId: Int) {
        self.taxonId = taxonId
    }
    
    func getPresentableName() -> String {
        var name: String = ""
        if let taxonRank = self.taxonRank {
            switch taxonRank {
            case "Species":
                name = self.species ?? ""
            case "Genus":
                name = self.genus ?? ""
            default:
                break
            }
        }
        return name
    }
    
    func getPresentableCategory() -> String {
        switch category {
        case "EX":
            return "Extinct"
        case "EW":
            return "Extinct in the Wild"
        case "CR":
            return "Critically Endangered"
        case "EN":
            return "Endangered"
        case "VU":
            return "Vulnerable"
        case "NT":
            return "Near Threatened"
        case "CD":
            return "Conservation Dependent"
        case "LC":
            return "Least Concern"
        default:
            return "Not Threatened"
        }
    }
    
    func getPresentableCategoryColor() -> String {
        switch category {
        case "EX":
            return "FF0000"
        case "EW":
            return "FF0000"
        case "CR":
            return "FF0000"
        case "EN":
            return "FF0000"
        case "VU":
            return "FFA500"
        case "NT":
            return "FFA500"
        case "CD":
            return "FFA500"
        case "LC":
            return "999900"
        default:
            return "000000"
        }
    }
    
    func getPresentableAuthorship() -> String {
        if let authorship = self.authorship {
            return authorship
                .replacingOccurrences(of: "(", with: "")
                .replacingOccurrences(of: ")", with: "")
        } else {
            return "Unkown"
        }
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
