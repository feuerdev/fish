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
    @IBOutlet weak var stvInfo: UIStackView!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var lblScientific: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var presenter: FamilyDetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ivPhoto.isSkeletonable = true
        lblVernacular.isSkeletonable = true
        lblScientific.isSkeletonable = true
        lblDescription.isSkeletonable = true
        
        lblDescription.skeletonLineSpacing = 0
        
        ivPhoto.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: skeletonColor))
        lblVernacular.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: skeletonColor))
        lblScientific.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: skeletonColor))
        lblDescription.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: skeletonColor))
    }
}
