//
//  FamilyListHeader.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 22.12.20.
//

import UIKit

protocol FamilyListHeaderDelegate {
    func didCollapse(danger:Danger, collapsed:Bool)
}

class FamilyListHeader: UICollectionReusableView {
    
    @IBOutlet weak var btnShowTitle: UIButton!
    @IBOutlet weak var btnShowImage: UIButton!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var delegate: FamilyListHeaderDelegate?
    
    var danger:Danger = .edGreen
    var count = 0
    var collapsed = false
    
    override func awakeFromNib() {
        self.view.layer.cornerRadius = defaultCornerRadius
        self.lblTitle.textColor = categoyHeaderColor
        
        let grTap = UITapGestureRecognizer(target: self, action: #selector(showHideSection(_:)))
        self.view.addGestureRecognizer(grTap)
    }
    
    @IBAction func showHideSection(_ sender: Any) {
        self.collapsed = !self.collapsed
        delegate?.didCollapse(danger: self.danger, collapsed: self.collapsed)
    }
    
    func updateButton() {
        self.btnShowTitle.setTitle("(\(self.count))", for: .normal)
        self.btnShowImage.transform = !self.collapsed ? .identity : .init(rotationAngle: 180 * CGFloat.pi/180)
    }
    
    func setup(danger:Danger, count:Int, collapsed:Bool) {
        self.count = count
        self.danger = danger
        self.collapsed = collapsed
        switch danger {
        case .edGreen:
            ivImage.image = UIImage(named: "whale30")
            view.backgroundColor = greenColor
            lblTitle.text = "Harmless and Wholesome"
        case .edYellow:
            ivImage.image = UIImage(named: "warning30")
            view.backgroundColor = yellowColor
            lblTitle.text = "Safe, but don't touch or feed"
        case .edRed:
            ivImage.image = UIImage(named: "alert30")
            view.backgroundColor = redColor
            lblTitle.text = "Dangerous, consult with local experts"
        }
        updateButton()
    }
}
