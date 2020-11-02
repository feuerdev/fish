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
        
        tableView.dataSource = self
    }
}

extension AnimalListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let animal = presenter?.animals?[indexPath.row] else {
            return cell
        }
        
        cell.textLabel?.text = animal.vernacular ?? animal.family
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.animals?.count else {
            return 0
        }
        return count
    }
}

extension AnimalListViewController: AnimalListPresenterDelegate {
    func refreshData() {
        self.tableView.reloadData()
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Oops", message: error, preferredStyle: .alert)
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
