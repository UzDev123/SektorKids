//
//  OTPVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 23/03/23.
//

import UIKit

class OTPVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var infoLabel: UILabel!{
        didSet{
            infoLabel.text = ""
        }
    }
    
    @IBOutlet weak var otp_TF: UITextField!{
        didSet{
            otp_TF.delegate = self
            otp_TF.font = .font(name: .roboto_bold, size: .r36)
            otp_TF.placeholder = "123456"
            otp_TF.textContentType = .oneTimeCode
        }
    }
    @IBOutlet weak var stopwatchLabel: UILabel!
    var phone : String = ""
    var timer : Timer!
    var counter = 120
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasdiqlash"
        timer = Timer(fire: .now, interval: 1, repeats: true, block: { t in
            if self.counter != 0{
                self.stopwatchLabel.text = "\(self.counter - 1) soniya"
                self.counter = self.counter - 1
            }
            
        })
        timer.fire()
    }

    override func viewDidLayoutSubviews() {
        infoLabel.text = "Tasdiqlash kodi \(phone) telefon raqamiga yuborildi. Iltimos, tasdiqlash kodini kiriting!"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text!.count == 6 && counter != 0{
            textField.resignFirstResponder()
            API.send_otp(phone: String(phone.dropFirst()), otp: textField.text!) { isSuccess in
                if isSuccess{
                    API.getMe { data in
                        //
                        if let window = UIApplication.shared.keyWindow {
                            window.rootViewController = MainTabbarVC()
                            window.makeKeyAndVisible()
                        }
                       
                    }
                    
                }
            }
            
        }
    }
}
