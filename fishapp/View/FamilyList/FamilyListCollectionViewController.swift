//
//  FamilyListCollectionViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 10.11.20.
//

import UIKit
import SkeletonView
import Feuerlib

class FamilyListCollectionViewController: UICollectionViewController {

    var presenter: FamilyListPresenter?
    var loadingView: FamilyListLoadingView?
    var dataSource = FamilyListDataSource()

    override func viewDidLoad() {
        self.title = "Families"

        if #available(iOS 11.0, *) {
            self.additionalSafeAreaInsets = .init(top: 10, left: 0, bottom: 0, right: 0)
        }

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        presenter?.viewDidLoad()
        self.dataSource.delegate = self
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = dataSource

        self.view.backgroundColor = backGroundColor2

        self.collectionView.isSkeletonable = true
        self.collectionView.showAnimatedSkeleton(usingColor: skeletonColor)

        let cell = UINib(nibName: IDENTIFIER_FAMILY_CELL, bundle: nil)
        let header = UINib(nibName: IDENTIFIER_FAMILY_HEADER, bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: IDENTIFIER_FAMILY_CELL)
        self.collectionView.register(header, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IDENTIFIER_FAMILY_HEADER)

        self.collectionView.backgroundColor = backGroundColor2

        self.loadingView = FamilyListLoadingView(centerIn: UIApplication.shared.keyWindow!)

    }

    override func viewWillDisappear(_ animated: Bool) {
        hideLoadingView()
    }

}

extension FamilyListCollectionViewController: AnimalListPresenterDelegate {

    func refreshCells() {

        if let animals = self.presenter?.interactor?.animals {
            self.dataSource.groups = Dictionary(grouping: animals) { (animal) -> Danger in
                return animal.danger // TODO move this to presenter/interactor
            }
        }

        self.collectionView.reloadData()
    }

    func showError(_ error: String) {
        self.showSimpleError(title: "Oops", message: error, popViewController: true)
    }

    func updateLoadingStatus(percent: Float) {
        self.loadingView?.pvProgress.setProgress(percent, animated: true)
    }

    func updateLoadingStatus(status: String) {
        self.loadingView?.lblProgress.text = status
    }

    func hideLoadingView() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.loadingView?.isHidden = true
        self.collectionView.stopSkeletonAnimation()
        self.collectionView.hideSkeleton()
        self.collectionView.isSkeletonable = false
    }
}

extension FamilyListCollectionViewController: FamilyListDataSourceDelegate {
    func familySelected(_ family: Family) {
        presenter?.familySelected(family)
    }
}
