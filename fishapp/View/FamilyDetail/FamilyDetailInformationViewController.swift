//
//  FamilyDetailInformationViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 09.01.21.
//

import UIKit
import SkeletonView

class FamilyDetailInformationViewController: UIViewController {

    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var lblScientific: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ivPhoto.isSkeletonable = true
        lblVernacular.isSkeletonable = true
        lblScientific.isSkeletonable = true
        lblDescription.isSkeletonable = true
        
        lblDescription.backgroundColor = .red
        lblScientific.backgroundColor = .green
        ivPhoto.backgroundColor = .blue
        lblVernacular.backgroundColor = .cyan
        
//        lblScientific.isHidden = true
    }
}
