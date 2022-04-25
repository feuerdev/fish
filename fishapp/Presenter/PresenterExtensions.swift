//
//  BasePresenter.swift
//  big-pond
//
//  Created by Jannik Feuerhahn on 12.01.21.
//

import UIKit

extension Family {

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
}

extension Species {
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

extension Danger {
    static func getColor(_ danger: Danger) -> UIColor {
        switch danger {
        case .edGreen:
            return greenColor
        case .edYellow:
            return yellowColor
        case .edRed:
            return redColor
        }
    }
}
