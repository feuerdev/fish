//
//  FamilyListHeader.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 22.12.20.
//

import UIKit

class FamilyListHeader: UICollectionReusableView {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        self.view.layer.cornerRadius = 15
    }
    
    func setDanger(_ danger:Danger) {
        switch danger {
        case .edGreen:
            view.backgroundColor = .green //TODO: Use better Colors
            lblTitle.text = "Harmless and Wholesome 🐠"
        case .edYellow:
            view.backgroundColor = .yellow
            lblTitle.text = "Safe, but don't touch or feed 🦈"
        case .edRed:
            view.backgroundColor = .red
            lblTitle.text = "Dangerous, consult with local experts ⚠️"
        }
    }
    
}
