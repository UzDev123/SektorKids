//
//  CreateChildVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 04/04/23.
//

import UIKit

class CreateChildVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var otpLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var phone_TF: UITextField!{
        didSet{
            phone_TF.delegate = self
            phone_TF.font = .font(name: .roboto_regular, size: .r14)
            phone_TF.textContentType = .telephoneNumber
            phone_TF.keyboardType = .phonePad
        }
    }
    @IBOutlet weak var age_TF: UITextField!{
        didSet{
            age_TF.delegate = self
            age_TF.font = .font(name: .roboto_regular, size: .r14)
            age_TF.keyboardType = .numberPad
        }
    }
    @IBOutlet weak var name_TF: UITextField!{
        didSet{
            name_TF.delegate = self
            name_TF.font = .font(name: .roboto_regular, size: .r14)
            name_TF.keyboardType = .default
            name_TF.textContentType = .name
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Farzandni qo'shish"
        backView.isHidden = true
        backView.alpha = 0
        otpView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
    }
    @IBAction func xButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.backView.alpha = 0
            self.otpView.transform = .init(scaleX: 0, y: 0)
        }
        backView.isHidden = true
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        API.create_child(name: name_TF.text!, age: Int(age_TF.text!)!, phone: phone_TF.text!) { code in
            self.otpLabel.text = code
        } completion: { isDone in
            if isDone{
                //Show OTP View
                self.backView.isHidden = false
                UIView.animate(withDuration: 0.3) {
                    self.backView.alpha = 1
                    self.otpView.transform = .identity
                }
               
               
            }
        }

    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == phone_TF && textField.text!.count == 13 {
            phone_TF.resignFirstResponder()
        }
        if textField == age_TF && textField.text!.count > 1{
            age_TF.resignFirstResponder()
        }
    }


}
