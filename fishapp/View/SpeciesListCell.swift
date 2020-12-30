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
    
    var cacheKey: Int?
    
    var species: Species? {
        didSet {
            if let species = species {
                self.cacheKey = species.taxonId
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
                    guard self.cacheKey == result.cacheKey else {
                        return
                    }
                    
                    switch result.result {
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.lblName.text = species.getPresentableName()
                            self.lblScientificName.isHidden = true
                            self.lblName.hideSkeleton()
                        }
                        break
                    case .success(let name):
                        DispatchQueue.main.async {
                            self.lblName.text = name
                            self.lblName.hideSkeleton()
                        }
                    }
                }
                
                if let searchTerm = species.species {
                    LoadPhotoService.loadPhoto(id: species.taxonId, searchParameter: searchTerm) { result in
                        guard result.cacheKey == self.cacheKey else {
                            return
                        }
                        switch result.result {
                        case .failure(_):
                            self.showNoPhoto(species: species)
                            break
                        case .success(let image):
                            DispatchQueue.main.async() {
                                self.ivImage.image = image
                                self.ivImage.hideSkeleton()
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
            self.ivImage.backgroundColor = pondColor
            self.lblNoPhoto.isHidden = false
        }
    }
}
