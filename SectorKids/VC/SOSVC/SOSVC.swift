//
//  SOSVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 25/03/23.
//

import UIKit
import MessageUI
class SOSVC: UIViewController , MFMessageComposeViewControllerDelegate{
   
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var messageButton: UIButton!{
        didSet{
            messageButton.isEnabled = false
        }
    }
    @IBOutlet weak var phoneButton: UIButton!{
        didSet{
            phoneButton.isEnabled = false
        }
    }
    @IBOutlet weak var sosButton: UIButton!{
        didSet{
            sosButton.layer.cornerRadius = sosButton.frame.height / 2
            sosButton.isEnabled = false
        }
    }
    var userData : UserDM?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SOS xizmati"
        navigationItem.backButtonTitle = ""
        segmentedControl.removeAllSegments()
        API.getMe { userDM in
            //
            self.userData = userDM
            if self.segmentedControl.numberOfSegments < userDM.children.count {
                for i in userDM.children.enumerated() {
                    self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: true)
                }
                self.sosButton.isEnabled = true
                self.messageButton.isEnabled = true
                self.phoneButton.isEnabled = true
                self.segmentedControl.selectedSegmentIndex = 0
            }
        }
        print(Cache.getUserToken(), 1111)
    }

    @IBAction func messageButtonTapped(_ sender: UIButton) {
        if MFMessageComposeViewController.canSendText() {
            let messageVC = MFMessageComposeViewController()
            messageVC.body = "This is a test message."
            messageVC.recipients = ["+998901234567"] // Phone number of the recipient
            messageVC.messageComposeDelegate = self
            self.present(messageVC, animated: true, completion: nil)
        } else {
            print("Cannot send text message.")
        }
    }
    
    @IBAction func callButtonTapped(_ sender: UIButton) {
        let phoneNumber = userData?.children[segmentedControl.selectedSegmentIndex].phone
        let numberUrl = URL(string: "tel://\(phoneNumber ?? "")")!
        if UIApplication.shared.canOpenURL(numberUrl) {
            UIApplication.shared.open(numberUrl)
        }
    }
    
    @IBAction func sosTapped(_ sender: UIButton) {
        if let user = userData {
            
            MySocket.default.sendSOS(child_id: user.children[segmentedControl.selectedSegmentIndex].id)
        }
    }
    

      func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
          switch result {
          case .cancelled:
              dismiss(animated: true, completion: nil)
          case .failed:
              dismiss(animated: true, completion: nil)
          case .sent:
              Alert.showAlert(forState: .success, message: "Jo'natildi", vibrationType: .success)
              dismiss(animated: true, completion: nil)
          default:
              break
          }
      }
    
}
