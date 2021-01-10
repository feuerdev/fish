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
    @IBOutlet weak var lblKingdom: UILabel!
    @IBOutlet weak var lblPhylum: UILabel!
    @IBOutlet weak var lblSubphylum: UILabel!
    @IBOutlet weak var lblSuperclass: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblSubclass: UILabel!
    @IBOutlet weak var lblOrder: UILabel!
    @IBOutlet weak var lblSuperfamily: UILabel!
    @IBOutlet weak var lblFamily: UILabel!
    @IBOutlet var ocTaxLabels: [UILabel]!
    
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
        
        ivPhoto.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: family.getPresentableColor()))
        lblVernacular.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: family.getPresentableColor()))
        lblScientific.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: family.getPresentableColor()))
        lblDescription.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: family.getPresentableColor()))
        
        presenter?.loadPhoto()
        presenter?.loadVernacular()
        presenter?.loadDescription()
        
        
        lblKingdom.text = presenter?.interactor.family.kingdom
        lblPhylum.text = presenter?.interactor.family.phylum
        lblSubphylum.text = presenter?.interactor.family.subphylum
        lblSuperclass.text = presenter?.interactor.family.superclass
        lblClass.text = presenter?.interactor.family.aclass
        lblSubclass.text = presenter?.interactor.family.subclass
        lblOrder.text = presenter?.interactor.family.order
        lblSuperfamily.text = presenter?.interactor.family.superfamily
        lblFamily.text = presenter?.interactor.family.family
        
        for lbl in ocTaxLabels {
            if lbl.text == nil {
                lbl.superview?.isHidden = true
            }
        }
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
