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
    @IBOutlet weak var ivPhoto: UIDocumentImageView!
    
    var animal: Family? {
        didSet {
            guard animal != nil else {
                return
            }
            
            if let filename = animal!.photoFileName {
                ivPhoto.loadImagefromDocuments(filename: filename)
            } else if animal!.noPhoto {
                //TODO: we dont have a photo, import no_photo.png or smth
                    ivPhoto.image = UIImage(named: "logo_png")
                }
            
            if let vernacular = animal?.vernacular {
                lblVernacular.text = vernacular
            } else if animal!.noVernacular {
                lblVernacular.text = "-"
    }
    
            lblLatin.text = animal?.family
        }
    }
    
    override func awakeFromNib() {
        self.view.layer.cornerRadius = 15
    }
}
