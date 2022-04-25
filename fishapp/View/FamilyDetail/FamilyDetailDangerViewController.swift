//
//  FamilyDetailDangerViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 09.01.21.
//

import UIKit

class FamilyDetailDangerViewController: UIViewController {

    @IBOutlet weak var lblEvaluation: UILabel!
    @IBOutlet weak var lblExplanation: UILabel!
    @IBOutlet weak var lblGeneralInformation: UILabel!
    var presenter: FamilyDetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblEvaluation.text = presenter?.presentableEvaluation()
        self.lblExplanation.text = presenter?.presentableDangerExplanation()
        self.lblGeneralInformation.text = presenter?.presentableGeneralInformation()
    }
}
