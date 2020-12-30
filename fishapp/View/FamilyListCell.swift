//
//  FamilyListCell.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 10.11.20.
//

import UIKit
import Feuerlib

class FamilyListCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblLatin: UILabel!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var lblNoPhoto: UILabel!
    @IBOutlet weak var ivPhoto: UIDocumentImageView!
    
    var cacheKey: Int?
    
    func setFamily(_ family: Family) {
        //Reset
        self.cacheKey = family.familyId
        self.lblNoPhoto.isHidden = true
        self.lblLatin.alpha = 1
        self.ivPhoto.backgroundColor = .clear
        self.ivPhoto.image = nil
        self.lblVernacular.text = ""
        self.lblLatin.text = ""
        
        //Skeleton
        self.lblLatin.isSkeletonable = false
        self.view.isSkeletonable = true
        self.lblVernacular.isSkeletonable = true
        self.ivPhoto.isSkeletonable = true
        self.view.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: skeletonColor))
        
        //Set
        self.lblLatin.text = family.family
        
        LoadVernacularService.loadVernacular(id: family.familyId) { result in
            guard result.cacheKey == self.cacheKey else {
                return
            }
            switch result.result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.lblVernacular.text = family.family
                    self.lblLatin.alpha = 0
                    self.lblVernacular.hideSkeleton()
                }
                break
            case .success(let name):
                DispatchQueue.main.async {
                    self.lblVernacular.text = name
                    self.lblVernacular.hideSkeleton()
                }
            }
        }
        
        if let searchTerm = family.family {
            LoadPhotoService.loadPhoto(id: family.familyId, searchParameter: searchTerm) { result in
                guard result.cacheKey == self.cacheKey else {
                    return
                }
                switch result.result {
                case .failure(_):
                    self.showNoPhoto(family: family)
                    break
                case .success(let image):
                    DispatchQueue.main.async() {
                        self.ivPhoto.image = image
                        self.ivPhoto.hideSkeleton()
                    }
                }
            }
        }
    }
    
    func showNoPhoto(family:Family) {
        DispatchQueue.main.async() {
            self.ivPhoto.image = nil
            self.ivPhoto.hideSkeleton()
            self.ivPhoto.backgroundColor = self.tintColor
            self.lblNoPhoto.isHidden = false
        }
    }
    
    override func awakeFromNib() {
        //clear
        self.lblVernacular.text = ""
        self.lblLatin.text = ""
        
        //Style
        self.view.layer.cornerRadius = defaultCornerRadius
        self.view.backgroundColor = backGroundColor2
        self.lblNoPhoto.textColor = textTintColor
        self.lblLatin.textColor = textTintColor
        self.lblVernacular.textColor = textTintColor
    }
}
