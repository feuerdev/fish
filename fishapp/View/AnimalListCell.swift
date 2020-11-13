//
//  AnimalListCell.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 10.11.20.
//

import UIKit

class AnimalListCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblLatin: UILabel!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    var animal: Animal? {
        didSet {
            lblLatin.text = animal?.family
            lblVernacular.text = animal?.vernacular
        }
    }
    
    override func awakeFromNib() {
        self.view.layer.cornerRadius = 15
        
    }
}
