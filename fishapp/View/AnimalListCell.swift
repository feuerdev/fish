//
//  AnimalListCell.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 10.11.20.
//

import UIKit

class AnimalListCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblLatin: UILabel!
    @IBOutlet weak var lblVernacular: UILabel!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    var animal: Family? {
        didSet {
            lblLatin.text = animal?.family
            lblVernacular.text = animal?.vernacular
            
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            if let fileName = animal?.photoFileName {
                DispatchQueue.global(qos: .userInitiated).async {
                    let fileUrl = documents.appendingPathComponent(fileName)
                    let img = UIImage(contentsOfFile: fileUrl.path) //TODO: Which thread does this run in?
                    DispatchQueue.main.async {
                        self.ivPhoto.image = img
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        ivPhoto.image = nil
    }
    
    override func awakeFromNib() {
        self.view.layer.cornerRadius = 15
        
    }
}
