//
//  FamilyListCell.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 10.11.20.
//

import UIKit
import Kingfisher

class FamilyListCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblLatin: UILabel!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var ivPhoto: UIDocumentImageView!
    
    var family: Family? {
        didSet {
            
            //Reset
            self.ivPhoto.image = nil
            self.lblVernacular.text = ""
            self.lblLatin.text = ""
            
            guard let family = family else {
                return
            }
            
            //Skeleton
            self.view.isSkeletonable = true
            self.lblLatin.isSkeletonable = true
            self.lblVernacular.isSkeletonable = true
            self.ivPhoto.isSkeletonable = true
            
            self.view.showAnimatedSkeleton()
            
            self.lblLatin.text = family.family
            self.lblLatin.hideSkeleton()
            
            LoadVernacularService.loadVernacular(id: family.familyId) { result in
                switch result {
                case .failure(_):
                    return
                case .success(let result):
                    if(family.familyId == result.familyId) { //Prevent loading the result after the cell has already been reused
                        DispatchQueue.main.async {
                            self.lblVernacular.text = result.vernacular
                            self.lblVernacular.hideSkeleton()
                        }
                    }
                }
            }
            
            
//            if let filename = family!.photoFileName {
//                ivPhoto.loadImagefromDocuments(filename: filename)
//            } else if family!.noPhoto {
//                //TODO: we dont have a photo, import no_photo.png or smth
//                ivPhoto.image = UIImage(named: "logo_png")
//            }
//
//            if let vernacular = family?.vernacular {
//                lblVernacular.text = vernacular
//            } else if family!.noVernacular {
//                lblVernacular.text = "-"
//            }
            
        }
    }
    
    override func awakeFromNib() {
        //Reset
        self.ivPhoto.image = nil
        self.lblLatin.text = ""
        self.lblVernacular.text = ""
        
        //Style
        self.view.layer.cornerRadius = 15
    }
}
