//
//  FamilyListLoadingView.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 25.11.20.
//

import UIKit

class FamilyListLoadingView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var pvProgress: UIProgressView!
    
    let nibName = "FamilyListLoadingView"
    var contentView:UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    convenience init(centerIn parent:UIView) {
        self.init(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        
        self.center = parent.center
        parent.addSubview(self)
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { 
            return 
        }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        
        contentView?.layer.cornerRadius = 10
        self.backgroundColor = .init(white: 0, alpha: 0)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
