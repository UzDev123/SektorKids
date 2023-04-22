//
//  OTPVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 23/03/23.
//

import UIKit

class OTPVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var otp_TF: UITextField!{
        didSet{
            otp_TF.delegate = self
            otp_TF.font = .font(name: .roboto_bold, size: .r36)
            otp_TF.placeholder = "123456"
            otp_TF.textContentType = .oneTimeCode
        }
    }
    var phone : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasdiqlash"
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text!.count == 6{
            textField.resignFirstResponder()
            API.send_otp(phone: String(phone.dropFirst()), otp: textField.text!) { isSuccess in
                if isSuccess{
                    API.getMe { data in
                        //
                        let vc = MainTabbarVC()
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc,animated: true)
                    }
                    
                }
            }
            
        }
    }
}
