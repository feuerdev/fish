//
//  InteractorExtensions.swift
//  big-pond
//
//  Created by Jannik Feuerhahn on 12.01.21.
//

import Foundation

extension Family {

    /**
     Calculates
     */
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

extension Species {
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
}
