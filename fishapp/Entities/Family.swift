//
//  Family.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import Foundation
import UIKit



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
    var dangerExplanation: String = "This species is harmless"
    
    init(_ taxonId: Int) {
        self.taxonId = taxonId
    }
    
    func generatePhotoSearchterms() -> [String] {
        var result = [String]()
        if let species = species {
            result.append(species)
        }
        if let genus = genus {
            result.append(genus)
        }
        if let family = family {
            result.append(family)
        }
        if let superfamily = self.superfamily {
            result.append(superfamily)
        }
        if let order = self.order {
            result.append(order)
        }
        if let subclass = self.subclass {
            result.append(subclass)
        }
        if let aclass = self.aclass {
            result.append(aclass)
        }
        return result
    }
    
    func getPresentableName() -> String? {
        guard let taxonRank = self.taxonRank else {
            return nil
        }
        switch taxonRank {
        case "Species":
            return self.species
        case "Genus":
            return self.genus
        default:
            return nil
        }
    }
    
    func getPresentableCategoryColor() -> UIColor {
        let green = greenColor.darker.darker
        let yellow = yellowColor.darker.darker
        let red = redColor.darker.darker
        switch category {
        case "EX":
            return red
        case "EW":
            return red
        case "CR":
            return red
        case "EN":
            return red
        case "VU":
            return yellow
        case "NT":
            return yellow
        case "CD":
            return yellow
        case "LC":
            return green
        default:
            return green
        }
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
    
    func getPresentableAuthorship() -> String {
        var result = ""
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
    
    func getPresentableInactiveTextColor() -> UIColor {
        var textColor: UIColor
        switch danger {
        case .edGreen:
            textColor = .init(white: 0.82, alpha: 1)
        default:
            textColor = .init(white: 0.3, alpha: 1)
        }
        return textColor
    }
    
    
    
    func generatePhotoSearchterms() -> [String] {
        var result = [String]()
        if let family = self.family {
            result.append(family)
        }
        for s in species {
            if let species = s.species {
                result.append(species)
            }
            if let genus = s.genus {
                result.append(genus)
            }
        }
        if let superfamily = self.superfamily {
            result.append(superfamily)
        }
        if let order = self.order {
            result.append(order)
        }
        if let subclass = self.subclass {
            result.append(subclass)
        }
        if let aclass = self.aclass {
            result.append(aclass)
        }
        return result
    }
}
