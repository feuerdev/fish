//
//  AnimalListCollectionViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 10.11.20.
//

import UIKit

class AnimalListCollectionViewController: UICollectionViewController {
    
    var presenter: AnimalListPresenter?
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        
        let nib = UINib(nibName: "AnimalListCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "AnimalListCell")
        self.collectionView.backgroundColor = .white
    }
    
    //MARK: - Datasource
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalListCell", for: indexPath) as! AnimalListCell
        guard let animal = presenter?.animals?[indexPath.row] else {
            return cell
        }
        
        cell.animal = animal
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
   
    
}

extension AnimalListCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding:CGFloat = 30
        let fullWidth = self.collectionView.frame.width - padding
        return CGSize(width: fullWidth/2, height: fullWidth/2)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 //TODO: Change this to 3 (Red, Yellow, Green)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = presenter?.animals?.count else {
            return 0
        }
        return count
    }
}

extension AnimalListCollectionViewController: AnimalListPresenterDelegate {
    func refreshData() {
        self.collectionView.reloadData()
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Oops", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    func updateLoadingStatus(status: String) {
        print(status)
//        self.lblLoadingStatus.text = status
    }
    
    func hideLoadingView() {
//        self.aiLoading.stopAnimating()
//        self.vLoading.isHidden = true
    }
}
