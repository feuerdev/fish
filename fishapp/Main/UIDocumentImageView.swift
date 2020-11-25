//
//  UIDocumentImageView.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 25.11.20.
//

import UIKit

class UIDocumentImageView: UIImageView {
    
    private var filename: String?
    
    func loadImagefromDocuments(filename: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            if !(self.filename == filename) {
                self.filename = filename
                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileUrl = documents.appendingPathComponent(filename)
                let img = UIImage(contentsOfFile: fileUrl.path)
                DispatchQueue.main.async {
                    self.image = img
                }
            }
        }
    }
}
