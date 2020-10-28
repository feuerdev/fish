//
//  AnimalListViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 21.10.20.
//

import UIKit

class AnimalListViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vLoading: UIView!
    @IBOutlet weak var lblLoadingStatus: UILabel!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    var presenter: AnimalListPresenter?
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        
        self.aiLoading.startAnimating()
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return animals.count
//        //TODO: presenter.numberOfRowsInSection()
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//        //TODO: return presenter.numberOfSections()
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.text = animals[indexPath.row].family
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.navigationController?.pushViewController(AnimalDetailViewController(animal:animals[indexPath.row]), animated: true) //TODO: Should this be handled by the router?
//    }
    
}

extension AnimalListViewController: AnimalListPresenterDelegate {
    func refreshData() {
        self.tableView.reloadData()
    }
    
    func showError(_ error: LocalizedError) {
        let alert = UIAlertController(title: "Oops", message: error.failureReason, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: {_ in 
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    func updateLoadingStatus(status: String) {
        self.lblLoadingStatus.text = status
    }
    
    func hideLoadingView() {
        self.aiLoading.stopAnimating()
        self.vLoading.isHidden = true
    }
    
    
}
