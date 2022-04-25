//
//  Family.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import Foundation
import UIKit

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

    init(_ familyId: Int) {
        self.familyId = familyId
    }
}
