//
//  Family.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import Foundation
import UIKit

enum Danger: Int {
    static let red = [
        484724, // Family Containing Box Jellyfish like Irukandji
        135479, // Species Portuguese man o' war
        344030, // Species Saltwater Crocodile
        105838, // Species White Shark
        105799, // Species Tiger Shark
    ]
    static let yellow = [
        266989, //Order of Venomous Box Jellyfish
        196069, //Order of Stingrays
        105689, //Family Requiem Sharks
        105694, //Family Hammerhead Sharks
        125595, //Family Scorpionfish
        154251, //Family Stonefish
        196202, //Family Crown of Thorns
        135239, //Family Containing Lion's mane jellyfish
        14107,  //Family Cone Snails
        125431, //Family Moray Eels
        125451, //Family Needlefishes
        413301, //Sub-Family of Sea snakes
        341430, //Genus Blue Ringed Octopus
        205902, //Genus Fire Corals
        123391, //Genus Toxopneustes (Toxic Sea Urchins)
        135261, //Genus Sea Nettles
        206646, //Genus Also Sea Nettles?
        135306, //Species Moon Jellyfish
        291140, //Species Cannonball Jellyfish
        219890, //Species Lagoon Triggerfish
        219875, //Species Titan Triggerfish
    ]
    
    static func getColor(_ danger:Danger) -> UIColor {
        switch danger {
        case .edGreen:
            return greenColor
        case .edYellow:
            return yellowColor
        case .edRed:
            return redColor
        }
    }
    
    case edGreen = 2, edYellow = 1, edRed = 0
}

let filteredSpecies = [
    889925, //Hexanauplia - Small crustaceans
]

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
    
    func getPresentableCategoryColor() -> UIColor {
        switch category {
        case "EX":
            return redColor
        case "EW":
            return redColor
        case "CR":
            return redColor
        case "EN":
            return redColor
        case "VU":
            return yellowColor
        case "NT":
            return yellowColor
        case "CD":
            return yellowColor
        case "LC":
            return greenColor
        default:
            return greenColor
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
    
    var kingdom: String?
    var phylum: String?
    var subphylum: String?
    var superclass: String?
    var aclass: String?
    var subclass: String?
    var order: String?
    var superfamily: String?
    var family: String?
    var sumRecords: Int = 0
    
    var species: [Species] = []
    
    var danger: Danger {
        var yellow = false
        for species in self.species {
            if species.danger == .edRed {
                return .edRed
            } else if species.danger == .edYellow {
                yellow = true
            }
        }
        
        if yellow {
            return .edYellow
        } else {
            return .edGreen
        }
    }
    
    init(_ familyId: Int) {
        self.familyId = familyId
    }
}
