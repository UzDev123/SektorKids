//
//  IDCardRegisterVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 23/03/23.
//

import UIKit

class IDCardRegisterVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.alpha = 0
        }
    }
    
    @IBOutlet weak var bottomView: UIView!{
        didSet{
            bottomView.transform = .init(translationX: 0, y: bottomView.frame.height + 40)
            bottomView.layer.cornerRadius = 40
            bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomView.clipsToBounds = true
        }
    }
    @IBOutlet weak var passportSerires_TF: UITextField!{
        didSet{
            passportSerires_TF.delegate = self
            passportSerires_TF.font = .font(name: .roboto_regular, size: .r14)
            passportSerires_TF.placeholder = "Passport/ID karta seriyasi va raqami"
        }
    }
    
    @IBOutlet weak var pinfl_TF: UITextField!{
        didSet{
            pinfl_TF.delegate = self
            pinfl_TF.font = .font(name: .roboto_regular, size: .r14)
            pinfl_TF.placeholder = "PINFL"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ro'yxatdan o'tish"
        navigationItem.backButtonTitle = ""
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }

    @IBAction func whatsPINFLTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.backView.alpha = 1
            self.bottomView.transform = .identity
        }
        
    }
    @IBAction func xButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.backView.alpha = 0
            self.bottomView.transform = .init(translationX: 0, y: self.bottomView.frame.height + 40)
        }
    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        //check Passport infos here
        
        let vc = MainTabbarVC()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,animated: true)
    }
}
