//
//  SOSVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 25/03/23.
//

import UIKit

class SOSVC: UIViewController {

    @IBOutlet weak var sosButton: UIButton!{
        didSet{
            sosButton.layer.cornerRadius = sosButton.frame.height / 2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SOS xizmati"
        navigationItem.backButtonTitle = ""
    }

    @IBAction func sosTapped(_ sender: UIButton) {
        
    }
}
