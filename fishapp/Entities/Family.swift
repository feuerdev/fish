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
        135342, // Family Portuguese man o' war
        105742, // Genus Great White Shark
        135479, // Species Portuguese man o' war
        344030, // Species Saltwater Crocodile
        105838, // Species White Shark
        105799, // Species Tiger Shark
    ]
    static let yellow = [
        10209,  //Order of Mackerel Sharks
        266989, //Order of Venomous Box Jellyfish
        196069, //Order of Stingrays
        105702, //Family of Great White + Mako
        105689, //Family Requiem Sharks
        105694, //Family Hammerhead Sharks
        125595, //Family Scorpionfish
        154251, //Family Stonefish
        196202, //Family Crown of Thorns
        135239, //Family Containing Lion's mane jellyfish
        14107,  //Family Cone Snails
        125431, //Family Moray Eels
        125451, //Family Needlefishes
        342638, //Family of Venomous Snakes
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
        135305, //Species Feuerqualle
        135301, //Species Feuerqualle
        135304, //Species Feuerqualle
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
    4, //Fungi
    5, 6, //Bacteria
    7, 8, //Single Cells
    801, 852, //Algae
    882, //Worms
    155670, //Water fleas
    146420, //Sea squirts
    889925, //Hexanauplia - small crustaceans
    845957, //Superclass of small crustaceans
    1069,   //Class of small crustaceans
    123084, //Class of Brittle Stars
    1836,   //Class of Birds
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
    
    func getPresentableCategory() -> NSMutableAttributedString {
        let green = [NSAttributedString.Key.foregroundColor: greenColor.darker.darker]
        let yellow = [NSAttributedString.Key.foregroundColor: yellowColor.darker.darker]
        let red = [NSAttributedString.Key.foregroundColor: redColor.darker.darker]
        let result = NSMutableAttributedString(string: "Conservation status: ")
        switch category {
        case "EX":
            result.append(NSMutableAttributedString(string: "Extinct", attributes: red))
        case "EW":
            result.append(NSMutableAttributedString(string: "Extinct in the Wild", attributes: red))
        case "CR":
            result.append(NSMutableAttributedString(string: "Critically Endangered", attributes: red))
        case "EN":
            result.append(NSMutableAttributedString(string: "Endangered", attributes: red))
        case "VU":
            result.append(NSMutableAttributedString(string: "Vulnerable", attributes: yellow))
        case "NT":
            result.append(NSMutableAttributedString(string: "Near Threatened", attributes: yellow))
        case "CD":
            result.append(NSMutableAttributedString(string: "Conservation Dependent", attributes: yellow))
        case "LC":
            result.append(NSMutableAttributedString(string: "Least Concern", attributes: green))
        default:
            result.append(NSMutableAttributedString(string: "Not Threatened", attributes: green))
        }
        return result
    }
    
    func getPresentableAuthorship() -> String {
        var result = "Discovered by: "
        if let authorship = self.authorship {
            result.append(authorship
                .replacingOccurrences(of: "(", with: "")
                .replacingOccurrences(of: ")", with: ""))
        } else {
            result.append("Unkown")
        }
        return result
    }
    
    func getPresentableColor() -> UIColor {
        var color: UIColor
        switch self.danger {
        case .edGreen:
            color = pondColor
        default:
            color = Danger.getColor(danger)
        }
        return color
    }
    
    func getPresentableTextColor() -> UIColor {
        var textColor: UIColor
        switch danger {
        case .edGreen:
            textColor = textTintColor
        default:
            textColor = .black
        }
        return textColor
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
    
    func getPresentableColor() -> UIColor {
        var color: UIColor
        switch self.danger {
        case .edGreen:
            color = pondColor
        default:
            color = Danger.getColor(danger)
        }
        return color
    }
    
    func getPresentableTextColor() -> UIColor {
        var textColor: UIColor
        switch danger {
        case .edGreen:
            textColor = textTintColor
        default:
            textColor = .black
        }
        return textColor
    }
}
