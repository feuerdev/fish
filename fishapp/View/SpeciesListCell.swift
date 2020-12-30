//
//  SpeciesListCell.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.11.20.
//

import UIKit
import Feuerlib

class SpeciesListCell: UITableViewCell {
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lblAuthorship: UILabel!
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblRisk: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblScientificName: UILabel!
    @IBOutlet weak var lblNoPhoto: UILabel!
    
    var cacheKey: String?
    
    var species: Species? {
        didSet {
            if let species = species {
                
                lblNoPhoto.isHidden = true
                lblScientificName.text = species.getPresentableName()
                lblAuthorship.text = species.getPresentableAuthorship()
                lblRank.text = species.taxonRank
                lblRisk.attributedText = species.getPresentableCategory()

                self.lblName.isSkeletonable = true
                self.lblName.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: skeletonColor))

                self.ivImage.isSkeletonable = true
                self.ivImage.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: skeletonColor))
                
                LoadVernacularService.loadVernacular(id: species.taxonId) { result in
                    switch result {
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.lblName.text = species.getPresentableName()
                            self.lblScientificName.isHidden = true
                            self.lblName.hideSkeleton()
                        }
                        break
                    case .success(let result):
                        if(species.taxonId == result.familyId) { //Prevent loading the result after the cell has already been reused
                            DispatchQueue.main.async {
                                self.lblName.text = result.vernacular
                                self.lblName.hideSkeleton()
                            }
                        }
                    }
                }
                
                if let searchTerm = species.species {
                    LoadPhotoService.loadPhoto(id: species.taxonId, searchParameter: searchTerm) { result in
                        switch result {
                        case .failure(_):
                            self.showNoPhoto(species: species)
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
                                            self.ivImage.image = image
                                            self.ivImage.hideSkeleton()
                                        }
                                    }
                                case .failure(_):
                                    break
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        self.lblRank.textColor = textTintColor
        self.lblRisk.textColor = textTintColor
        self.lblName.textColor = textTintColor
        self.lblAuthorship.textColor = textTintColor
        self.lblScientificName.textColor = textTintColor
        self.lblNoPhoto.textColor = textTintColor
    }
    
    func showNoPhoto(species:Species) {
        DispatchQueue.main.async() {
            self.ivImage.image = nil
            self.ivImage.hideSkeleton()
            self.ivImage.backgroundColor = self.tintColor
            self.lblNoPhoto.isHidden = false
        }
    }
}
