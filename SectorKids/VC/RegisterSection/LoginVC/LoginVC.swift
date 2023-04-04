//
//  LoginVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 03/04/23.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var password_TF: UITextField!{
        didSet{
            password_TF.delegate = self
            password_TF.placeholder = "Parolni kiriting"
            password_TF.font = .font(name: .roboto_regular, size: .r14)
            password_TF.setEyeButton(UIImage(named: "invisible") ?? UIImage())
        }
    }
    @IBOutlet weak var phone_TF: UITextField!{
        didSet{
            phone_TF.delegate = self
            phone_TF.font = .font(name: .roboto_regular, size: .r14)
            phone_TF.placeholder = "+998XXXXXXXXX"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = " "
        title = "Kirish"
    }
    override func viewDidLayoutSubviews() {
        loginButton.layer.cornerRadius = 5
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        if phone_TF.text!.count < 13{
            Alert.showAlert(forState: .warning, message: "Telefon raqamni to'g'ri kiriting", vibrationType: .warning)
        }else{
            API.login(phone: String(phone_TF.text!.dropFirst()), password: password_TF.text!) { success in
                if success{
                    let vc = MainTabbarVC()
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc,animated: true)
                }
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == phone_TF && textField.text!.count > 13{
            textField.resignFirstResponder()
        }
    }
}
