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
    
    var cacheKey: String?
    
    func setFamily(_ family: Family) {
        //Reset
        self.lblNoPhoto.isHidden = true
        self.ivPhoto.backgroundColor = .clear
        self.ivPhoto.image = nil
        self.lblVernacular.text = ""
        self.lblLatin.text = ""
        self.cacheKey = ""
        
        //Skeleton
        self.view.isSkeletonable = true
        self.lblLatin.isSkeletonable = false
        self.lblVernacular.isSkeletonable = false
        self.ivPhoto.isSkeletonable = true
        
        self.view.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: skeletonColor))
        
        self.lblLatin.text = family.family
        self.lblLatin.hideSkeleton()
        
        LoadVernacularService.loadVernacular(id: family.familyId) { result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.lblVernacular.text = family.family
                    self.lblLatin.isHidden = true
                    self.lblVernacular.hideSkeleton()
                }
                break
            case .success(let result):
                if(family.familyId == result.familyId) { //Prevent loading the result after the cell has already been reused
                    DispatchQueue.main.async {
                        self.lblVernacular.text = result.vernacular
                        self.lblVernacular.hideSkeleton()
                    }
                }
            }
        }
        
        if let searchTerm = family.family {
            LoadPhotoService.loadPhoto(id: family.familyId, searchParameter: searchTerm) { result in
                switch result {
                case .failure(_):
                    self.showNoPhoto(family: family)
                    break
                case .success(let result):
                    self.cacheKey = result.url
                    ImageCache.shared.getImage(from: result.url) { [weak self] result in
                        guard let self = self else {
                            return
                        }
                        switch result {
                        case .success((let cacheKey, let image)):
                            if self.cacheKey == cacheKey {
                                DispatchQueue.main.async() {
                                    self.ivPhoto.image = image
                                    self.ivPhoto.hideSkeleton()
                                }
                            }
                        case .failure(let error):
                            print(error)
                            self.showNoPhoto(family: family)
                            break
                        }
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
        //Reset
        self.ivPhoto.image = nil
        self.lblLatin.text = ""
        self.lblVernacular.text = ""
        
        //Style
        self.view.layer.cornerRadius = defaultCornerRadius
        self.view.backgroundColor = backGroundColor2
        self.lblNoPhoto.textColor = textTintColor
        self.lblLatin.textColor = textTintColor
        self.lblVernacular.textColor = textTintColor
    }
}
