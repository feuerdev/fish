//
//  FamilyDetailSpeciesListCell.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 09.01.21.
//

import UIKit

class FamilyDetailSpeciesListCell: UITableViewCell {
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var lblScientific: UILabel!
    @IBOutlet weak var lblAuthorship: UILabel!
    @IBOutlet weak var lblConservationStatus: UILabel!
    
    
    var cacheKey: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.ivPhoto.isSkeletonable = true
        self.lblVernacular.isSkeletonable = true
        self.lblScientific.isSkeletonable = true
    }
    
    var species: Species? {
        didSet {
            if let species = species {
                self.cacheKey = species.taxonId
                
                self.lblAuthorship.text = species.getPresentableAuthorship()
                self.lblConservationStatus.text = species.getPresentableCategory()
                self.lblConservationStatus.textColor = species.getPresentableCategoryColor()
                
                self.ivPhoto.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: species.getPresentableColor()))
                self.lblVernacular.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: species.getPresentableColor()))
                self.lblScientific.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: species.getPresentableColor()))
                
                LoadVernacularService.loadVernacular(id: species.taxonId) { result in
                    guard self.cacheKey == result.cacheKey else {
                        return
                    }
                    
                    switch result.result {
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.lblVernacular.text = species.getPresentableName()
                            self.lblScientific.isHidden = true
                        }
                        break
                    case .success(let name):
                        DispatchQueue.main.async {
                            self.lblVernacular.text = name
                            self.lblScientific.text = species.getPresentableName()
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.lblVernacular.hideSkeleton()
                        self.lblScientific.hideSkeleton()
                    }
                }
                
                LoadPhotoService.loadPhoto(id: species.taxonId, searchParameters: species.generatePhotoSearchterms()) { result in
                    guard result.cacheKey == self.cacheKey else {
                        return
                    }
                    switch result.result {
                    case .failure(_):
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
    }
}
