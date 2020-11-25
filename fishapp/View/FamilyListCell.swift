//
//  FamilyListCell.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 10.11.20.
//

import UIKit

class FamilyListCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblLatin: UILabel!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var ivPhoto: UIDocumentImageView!
    
    var family: Family? {
        didSet {
            guard family != nil else {
                return
            }
            
            if let filename = family!.photoFileName {
                ivPhoto.loadImagefromDocuments(filename: filename)
            } else if family!.noPhoto {
                //TODO: we dont have a photo, import no_photo.png or smth
                ivPhoto.image = UIImage(named: "logo_png")
            }
            
            if let vernacular = family?.vernacular {
                lblVernacular.text = vernacular
            } else if family!.noVernacular {
                lblVernacular.text = "-"
            }
            
            lblLatin.text = family?.family
        }
    }
    
    override func awakeFromNib() {
        self.ivPhoto.image = nil
        self.lblLatin.text = ""
        self.lblVernacular.text = ""
        
        self.isSkeletonable = true
        self.lblLatin.isSkeletonable = true
        self.lblVernacular.isSkeletonable = true
        self.ivPhoto.isSkeletonable = true
        self.view.layer.cornerRadius = 15
    }
}
