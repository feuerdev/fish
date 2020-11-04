//
//  Util.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 27.10.20.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

enum ServiceError : Error {
    case badUrl
    case noNetwork
    case noData
    case parserError
}
