//
//  Animal.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import Foundation

enum Danger {
    case edGreen, edYellow, edRed
}

struct Animal {
    var family: String?
    var category: Danger?
}
