//
//  WelcomeVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 17/03/23.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            loginButton.setTitle("Kirish", for: .normal)
            loginButton.titleLabel?.font = .font(name: .roboto_regular, size: .r16)
            loginButton.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var registerButton: UIButton!{
        didSet{
            registerButton.setTitle("Ro'yxatdan o'tish", for: .normal)
            registerButton.titleLabel?.font = .font(name: .roboto_regular, size: .r16)
            registerButton.layer.cornerRadius = 5
            registerButton.layer.borderWidth = 1
            registerButton.layer.borderColor = #colorLiteral(red: 0.06302668899, green: 0.1151151434, blue: 0.301756084, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = " "
        // Do any additional setup after loading the view.
    }


    @IBAction func loginTapped(_ sender: UIButton) {
        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func registerTapped(_ sender: UIButton) {
        let vc = RegisterVC(nibName: "RegisterVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
