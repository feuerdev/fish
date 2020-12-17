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
    
    var cacheKey: String?
    
    var species: Species? {
        didSet {
            if let species = species {
                lblScientificName.text = species.getPresentableName()
                lblAuthorship.text = species.getPresentableAuthorship()
                lblRank.text = species.taxonRank
                lblRisk.text = species.getPresentableCategory()
                lblRisk.textColor = UIColor(hexString: species.getPresentableCategoryColor())

                self.lblName.isSkeletonable = true
                self.lblName.showAnimatedSkeleton(usingColor: .wetAsphalt)

                self.ivImage.isSkeletonable = true
                self.ivImage.showAnimatedSkeleton(usingColor: .wetAsphalt)
                
                LoadVernacularService.loadVernacular(id: species.taxonId) { result in
                    switch result {
                    case .failure(_):
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
}
