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
    
    var animal: Family? {
        didSet {
            lblLatin.text = animal?.family
            lblVernacular.text = animal?.vernacular
            if let filename = animal?.photoFileName {
                ivPhoto.loadImagefromDocuments(filename: filename)
            } else if let noPhoto = animal?.noPhoto {
                if noPhoto {
                    ivPhoto.image = UIImage(named: "logo_png")
                }
            } else {
                ivPhoto.image = UIImage(named: "logo_full")
            }
        }
    }
    
    override func prepareForReuse() {
        ivPhoto.image = nil
    }
    
    override func awakeFromNib() {
        self.view.layer.cornerRadius = 15
    }
}
