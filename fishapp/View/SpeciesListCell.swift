//
//  SpeciesListCell.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.11.20.
//

import UIKit

class SpeciesListCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var ivImage: UIDocumentImageView!
    @IBOutlet weak var lblAuthorship: UILabel!
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblRisk: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblScientificName: UILabel!
    @IBOutlet weak var lblRecords: UILabel!
    @IBOutlet weak var swMarine: UISwitch!
    
    var species: Species? {
        didSet {
//            ivImage.image =
            if let species = species {
                if let filename = species.photoFileName {
                    ivImage.loadImagefromDocuments(filename: filename)
                }
                lblName.text = species.vernacular
                lblScientificName.text = species.getPresentableName()
                lblAuthorship.text = species.getPresentableAuthorship()
                lblRank.text = species.taxonRank
                lblRisk.text = species.getPresentableCategory()
                lblRisk.textColor = UIColor(hexString: species.getPresentableCategoryColor())
                
                if let records = species.records {
                    lblRecords.text = String(records)
                }
                if let isMarine = species.isMarine {
                    swMarine.isOn = isMarine
                }
            }
            
//            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            if let fileName = animal?.photoFileName {
//                DispatchQueue.global(qos: .userInitiated).async {
//                    let fileUrl = documents.appendingPathComponent(fileName)
//                    let img = UIImage(contentsOfFile: fileUrl.path) //TODO: Which thread does this run in?
//                    DispatchQueue.main.async {
//                        self.ivPhoto.image = img
//                    }
//                }
//            }
        }
    }

    override func prepareForReuse() {
        ivImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer.cornerRadius = 15
    }

}
