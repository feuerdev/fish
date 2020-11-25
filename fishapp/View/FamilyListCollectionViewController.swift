//
//  FamilyListCollectionViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 10.11.20.
//

import UIKit
import SkeletonView

class FamilyListCollectionViewController: UICollectionViewController {
    
    let IDENTIFIER_CELL = "FamilyListCell"
    
    var presenter: FamilyListPresenter?
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        
        self.collectionView.isSkeletonable = true
        self.collectionView.showAnimatedSkeleton()
        
        let nib = UINib(nibName: IDENTIFIER_CELL, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: IDENTIFIER_CELL)
        self.collectionView.backgroundColor = .white
    }
    
    //MARK: - Datasource
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension FamilyListCollectionViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return IDENTIFIER_CELL
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: IDENTIFIER_CELL, for: indexPath) as! FamilyListCell
        guard let animal = presenter?.interactor?.animals[safe: indexPath.row] else {
            return cell
        }
        
        cell.family = animal
        
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 //TODO: Change this to 3 (Red, Yellow, Green)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = presenter?.interactor?.animals.count else {
            return 0
        }
        return count
    }
}

extension FamilyListCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding:CGFloat = 30
        let fullWidth = self.collectionView.frame.width - padding
        return CGSize(width: fullWidth/2, height: fullWidth/2)
    }
}

extension FamilyListCollectionViewController: AnimalListPresenterDelegate {
    func refreshCell(indexPath: IndexPath) {
        self.collectionView.reloadItems(at: [indexPath])
    }
    
    func refreshCells() {
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
        //
    }
    
    func hideLoadingView() {
        self.collectionView.stopSkeletonAnimation()
        self.collectionView.hideSkeleton()
    }
}
