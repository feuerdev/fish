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
        
        guard let family = presenter?.interactor.family else {
            return
        }
        
        //Don't let content be hidden under bottom Tab bar (Needed for iOS 10 and earlier, from iOS 11 use safe area layout guides)
        self.edgesForExtendedLayout = [.top, .left, .right]

        ivPhoto.isSkeletonable = true
        lblVernacular.isSkeletonable = true
        lblScientific.isSkeletonable = true
        lblDescription.isSkeletonable = true
        
        lblDescription.skeletonLineSpacing = 0
        
        ivPhoto.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: family.getPresentableColor()))
        lblVernacular.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: family.getPresentableColor()))
        lblScientific.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: family.getPresentableColor()))
        lblDescription.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: family.getPresentableColor()))
        
        presenter?.loadPhoto()
        presenter?.loadVernacular()
        presenter?.loadDescription()
    }
}

extension FamilyDetailInformationViewController: FamilyDetailPresenterDelegate {

    func photoLoaded(_ photo: UIImage?) {
        DispatchQueue.main.async {
            if let photo = photo {
                self.ivPhoto.image = photo
                self.ivPhoto.hideSkeleton()
            }
        }
    }
    
    func vernacularLoaded(_ vernacular: String?) {
        DispatchQueue.main.async {
            if let vernacular = vernacular {
                self.lblVernacular.text = vernacular
                self.lblScientific.text = self.presenter?.interactor.family.family
            } else {
                self.lblVernacular.text = self.presenter?.interactor.family.family
                self.lblScientific.isHidden = true
            }
            
            self.lblVernacular.hideSkeleton()
            self.lblScientific.hideSkeleton()
        }
    }
    
    func descriptionLoaded(_ description: String?) {
        DispatchQueue.main.async {
            if let description = description {
                self.lblDescription.text = description
            } else {
                self.lblDescription.text = "Sorry, couldn't find a description :("
            }
            
            self.lblDescription.hideSkeleton()
        }
    }
}
