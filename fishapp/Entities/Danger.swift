//
//  Danger.swift
//  big-pond
//
//  Created by Jannik Feuerhahn on 11.01.21.
//

import UIKit

enum Danger:Int {
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
    
    case edRed, edYellow, edGreen 
}

struct Classification {
    let danger:Danger
    let explanation:String
    
    static let data:Dictionary<Int, Classification> = [
        //Red
        484724:Classification(danger: .edRed, explanation: "Family Containing Box Jellyfish like Irukandji"),
        135342:Classification(danger: .edRed, explanation: "Family Portuguese man o' war"),
        105742:Classification(danger: .edRed, explanation: "Genus Great White Shark"),
        135479:Classification(danger: .edRed, explanation: "Species Portuguese man o' war"),
        344030:Classification(danger: .edRed, explanation: "Species Saltwater Crocodile"),
        105838:Classification(danger: .edRed, explanation: "Species White Shark"),
        105799:Classification(danger: .edRed, explanation: "Species Tiger Shark"),
        //Yellow
        10209:Classification(danger: .edYellow, explanation: "/Order of Mackerel Sharks"),
        266989:Classification(danger: .edYellow, explanation: "Order of Venomous Box Jellyfish"),
        196069:Classification(danger: .edYellow, explanation: "Order of Stingrays"),
        105702:Classification(danger: .edYellow, explanation: "Family of Great White + Mako"),
        105689:Classification(danger: .edYellow, explanation: "Family Requiem Sharks"),
        105694:Classification(danger: .edYellow, explanation: "Family Hammerhead Sharks"),
        125595:Classification(danger: .edYellow, explanation: "Family Scorpionfish"),
        154251:Classification(danger: .edYellow, explanation: "Family Stonefish"),
        196202:Classification(danger: .edYellow, explanation: "Family Crown of Thorns"),
        135239:Classification(danger: .edYellow, explanation: "Family Containing Lion's mane jellyfish"),
        14107:Classification(danger: .edYellow, explanation: "/Family Cone Snails"),
        125431:Classification(danger: .edYellow, explanation: "Family Moray Eels"),
        125451:Classification(danger: .edYellow, explanation: "Family Needlefishes"),
        342638:Classification(danger: .edYellow, explanation: "Family of Venomous Snakes"),
        413301:Classification(danger: .edYellow, explanation: "Sub-Family of Sea snakes"),
        341430:Classification(danger: .edYellow, explanation: "Genus Blue Ringed Octopus"),
        205902:Classification(danger: .edYellow, explanation: "Genus Fire Corals"),
        123391:Classification(danger: .edYellow, explanation: "Genus Toxopneustes (Toxic Sea Urchins)"),
        135261:Classification(danger: .edYellow, explanation: "Genus Sea Nettles"),
        206646:Classification(danger: .edYellow, explanation: "Genus Also Sea Nettles?"),
        135306:Classification(danger: .edYellow, explanation: "Species Moon Jellyfish"),
        291140:Classification(danger: .edYellow, explanation: "Species Cannonball Jellyfish"),
        219890:Classification(danger: .edYellow, explanation: "Species Lagoon Triggerfish"),
        219875:Classification(danger: .edYellow, explanation: "Species Titan Triggerfish"),
        135305:Classification(danger: .edYellow, explanation: "Species Feuerqualle"),
        135301:Classification(danger: .edYellow, explanation: "Species Feuerqualle"),
        135304:Classification(danger: .edYellow, explanation: "Species Feuerqualle"),
        ]
}
