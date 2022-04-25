//
//  AnimalListPresenter.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 28.10.20.
//

import Foundation
import FirebaseAnalytics

protocol AnimalListPresenterDelegate: AnyObject {
    func updateLoadingStatus(status: String)
    func updateLoadingStatus(percent: Float)
    func refreshCells()
    func hideLoadingView()
    func showError(_ error: String)
}

class FamilyListPresenter {

    var interactor: FamilyListInteractor?
    var router: AnimalListRouter?
    weak var viewDelegate: AnimalListPresenterDelegate?

    func viewDidLoad() {
        interactor?.loadAnimals()
    }

    func familySelected(_ family: Family) {
        router?.pushToAnimalDetailView(view: viewDelegate!, with: family)
        Analytics.logEvent(AnalyticsEventViewItem, parameters: [
            AnalyticsParameterItemID: family.familyId
        ])
    }
}

extension FamilyListPresenter: FamilyListInteractorDelegate {

    func loadAnimalsSuccess() {
        DispatchQueue.main.async {
            guard let count = self.interactor?.animals.count,
                  count > 0 else {
                self.viewDelegate?.hideLoadingView()
                self.viewDelegate?.showError("Didn't find any animals here :(")
                return
            }

            self.viewDelegate?.refreshCells()
            self.viewDelegate?.hideLoadingView()
        }
    }

    func loadAnimalsFailure(error: String) {
        DispatchQueue.main.async {
            self.viewDelegate?.showError(error)
        }
    }

    func loadAnimalsStatusUpdate(status: String) {
        DispatchQueue.main.async {
            self.viewDelegate?.updateLoadingStatus(status: status)
        }
    }

    func loadAnimalsStatusUpdate(percent: Float) {
        DispatchQueue.main.async {
            self.viewDelegate?.updateLoadingStatus(percent: percent)
        }
    }

}
