//
//  RegisterVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 17/03/23.
//

import UIKit

class RegisterVC: UIViewController {
    
    let privacy_policy = "Maxfiylik siyosati"
    
    @IBOutlet weak var lineWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var lineView1: UIView!
    
    @IBOutlet weak var phone_TF: UITextField!{
        didSet{
            phone_TF.delegate = self
            phone_TF.font = .font(name: .roboto_regular, size: .r14)
            phone_TF.placeholder = "+998XXXXXXXXX"
        }
    }
    
    @IBOutlet weak var re_password_TF: UITextField!{
        didSet{
            re_password_TF.delegate = self
            re_password_TF.font = .font(name: .roboto_regular, size: .r14)
            re_password_TF.placeholder = "Parolni qayta kiriting"
        }
    }
    @IBOutlet weak var password_TF: UITextField!{
        didSet{
            password_TF.delegate = self
            password_TF.placeholder = "Parolni kiriting"
            password_TF.font = .font(name: .roboto_regular, size: .r14)
            password_TF.setEyeButton(UIImage(named: "invisible") ?? UIImage())
        }
    }
    @IBOutlet weak var privacyLabel: UILabel!{
        didSet{
            privacyLabel.font = .font(name: .roboto_regular, size: .r12)
        }
    }
    
    @IBOutlet weak var howToRegisterLabel: UILabel!{
        didSet{
            howToRegisterLabel.text = "Qanday qilib ro'yxatdan o'tish mumkin?"
        }
    }
    @IBOutlet weak var passwordStrengthLabel: UILabel!{
        didSet{
            passwordStrengthLabel.text =  "Parolning qiyinlik darajasi"
        }
    }
    @IBOutlet weak var registerButton: UIButton!{
        didSet{
            registerButton.layer.cornerRadius = 5
            registerButton.setTitle("Ro'yxatdan o'tish", for: .normal)
            registerButton.titleLabel?.font = .font(name: .roboto_regular, size: .r16)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ro'yxatdan o'tish"
        navigationItem.backButtonTitle = ""
        setupLabel()
    }
    
    override func viewDidLayoutSubviews() {
        lineView.layer.cornerRadius = lineView.frame.height / 2
        
    }
    
    func setupLabel() {
        
        //Maxfiylik siyosati
        let fullString = "Tasdiqlash tugmasini bosish orqali siz " + privacy_policy + " shartlariga rozilik bildirasiz!"
        let strNSString: NSString = fullString as NSString
        let rangeNumber = (strNSString).range(of: privacy_policy)
        let attribute = NSMutableAttributedString.init(string: fullString)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: rangeNumber)
        attribute.addAttribute(NSAttributedString.Key.font, value:  UIFont.font(name: .roboto_regular, size: .r12), range: rangeNumber)
        
        
        privacyLabel.attributedText = attribute
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(privacy_tapped))
        privacyLabel.addGestureRecognizer(tapGesture)
        privacyLabel.isUserInteractionEnabled = true
        
        //Qanday qilib ro'yxatdan o'tish
        let strNSString1: NSString = howToRegisterLabel.text! as NSString
        let attribute1 = NSMutableAttributedString.init(string: howToRegisterLabel.text!)
        let rangeNumber1 = (strNSString1).range(of: howToRegisterLabel.text!)
        attribute1.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: rangeNumber1)
        attribute1.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: rangeNumber1)
        attribute1.addAttribute(NSAttributedString.Key.font, value:  UIFont.font(name: .roboto_regular, size: .r14), range: rangeNumber1)
        
        howToRegisterLabel.attributedText = attribute1
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(how_to_register_tapped))
        howToRegisterLabel.addGestureRecognizer(tapGesture1)
        howToRegisterLabel.isUserInteractionEnabled = true
        
    }
    @objc func how_to_register_tapped(_ gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
        
        let text = self.howToRegisterLabel.text ?? ""
        let recoverStr = (text as NSString).range(of: howToRegisterLabel.text!)
        
        if gesture.didTapAttributedTextInLabel(label: howToRegisterLabel, inRange: recoverStr) {
            //open web
            print("Qanday qilib ro'yxatdan o'tish")
        }
    }
    
    @objc func privacy_tapped(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        let text = self.privacyLabel.text ?? ""
        let recoverStr = (text as NSString).range(of: privacy_policy)
        
        if gesture.didTapAttributedTextInLabel(label: privacyLabel, inRange: recoverStr) {
            //open web
            print("MAXFIYLIK SIYOSATI")
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if phone_TF.text!.count != 13 {
            Alert.showAlert(forState: .warning, message: "Telefon raqamni to'g'ri kiriting.", vibrationType: .warning)
        }else if password_TF.text! != re_password_TF.text!{
            Alert.showAlert(forState: .warning, message: "Parolning mosligini tekshiring.", vibrationType: .warning)
        }else{
            API.register(phone: phone_TF.text!, password: password_TF.text!) { isSuccess in
                if isSuccess{
                    let vc = OTPVC(nibName: "OTPVC", bundle: nil)
                    vc.phone = self.phone_TF.text!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    
}


extension RegisterVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == phone_TF {
            if !(textField.text!.count <= 13){
                textField.resignFirstResponder()
            }
        }
        
        if textField == password_TF {
            let hasLowerLetter = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z]).{1,}$")
            let hasCapitalLetter = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[A-Z]).{1,}$")
            let hasSpecialCharacters = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[$@$#!%*?_&.-]).{1,}$")
            var c = 0
            if hasLowerLetter.evaluate(with: textField.text!) {
                c += 1
            }
            if hasCapitalLetter.evaluate(with: textField.text!){
                c += 1
            }
            if hasSpecialCharacters.evaluate(with: textField.text!){
                c += 1
            }
            if c == 0 {
                lineWidthConstraint.constant = 0
                
            }else{
                lineWidthConstraint.constant = lineView.frame.width / CGFloat(4 - c)
                lineView1.backgroundColor = c == 3 ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) : c == 2 ? .orange : .red
            }
            
            
        }
    }
    
    
}
