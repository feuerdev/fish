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
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var species: Species? {
        didSet {
            
        }
    }

}
