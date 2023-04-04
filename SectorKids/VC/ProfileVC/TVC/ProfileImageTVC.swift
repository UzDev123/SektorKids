//
//  ProfileImageTVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 24/03/23.
//

import UIKit

protocol ProfileTVCDelegate{
    func didEditButtonTapped()
}
class ProfileImageTVC: UITableViewCell {

    static func getProfileImageTVC() -> UINib{
        return UINib(nibName: "ProfileImageTVC", bundle: nil)
    }
    static var getProfileImageTVCID : String {
        return "ProfileImageTVC"
    }
    
    
    @IBOutlet weak var userImgView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    var delegate : ProfileTVCDelegate?
    var userData : UserDM!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func updateCell(userData : UserDM){
        nameLabel.text = userData.name
        phoneLabel.text = userData.phone
        userImgView.layer.cornerRadius = userImgView.frame.height / 2
    }
    
    
    @IBAction func editTapped(_ sender: UIButton) {
        delegate?.didEditButtonTapped()
    }
    
    
}
