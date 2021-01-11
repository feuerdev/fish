//
//  InfoViewController.swift
//  fishapp
//
//  Created by Jannik Feuerhahn on 29.12.20.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var tvContent: UITextView!
    
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var svContent: UIScrollView!
    @IBOutlet weak var stvContent: UIStackView!
    override func viewDidLoad() {
        self.view.backgroundColor = pondColor
        self.lblContent.textColor = textTintColor
        
        self.lblContent.text =
            """
            Thank you for using my App!
            
            FAQ:
            
            Q: Why is there no photo?
            A: I'm currently getting the photos from Wikipedia. If the Wiki article has no photo, I can not display it in the app.
                        
            Q: Where do you get the animal data from?
            A: Animal occurence data comes from OBIS - A Marine Life Database

            Q: Where do you get the vernacular(common) name from?
            A: I get the english name of the animals from WORMS - Another Marine Life Database

            Q: Where does the categorization come from?
            A: That was me! I'm not an expert though, so if you want to change a classification please let me know!

            Credit:
            
            OBIS - Marine Life Data:
                OBIS (YEAR) Ocean Biodiversity Information System. Intergovernmental Oceanographic Commission of UNESCO. www.iobis.org.

            WoRMS - Vernacular Names:
                WoRMS Editorial Board (2020). World Register of Marine Species. Available from https://www.marinespecies.org at VLIZ. Accessed 2020-12-29. doi:10.14284/170

            Map Tiles - OSM
                © OpenStreetMap contributors
                www.openstreetmap.org/copyright or www.opendatacommons.org/licenses/odbl.
                

            Contact Info:
            jannik@feuer.dev
            https://feuer.dev


            """
        
        tvContent.text = lblContent.text
        tvContent.tintColor = textTintColor
        tvContent.linkTextAttributes = [.underlineStyle: 1]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        svContent.contentSize = CGSize(width: svContent.frame.width, height: stvContent.frame.height)
    }
    
}
