//
//  ProfileVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 16/03/23.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ProfileImageTVC.getProfileImageTVC(), forCellReuseIdentifier: ProfileImageTVC.getProfileImageTVCID)
        }
    }
    var data = [
        "Sozlamalar",
        "Call center",
        "Biz haqimizda",
        "Chiqish",
        "Profilni o'chirish"
    ]
    
    var cellImages = [
        UIImage(named: "headphone_profile"),
        UIImage(named: "info_profile"),
        UIImage(named: "settings_profile"),
        UIImage(named: "signout_profile"),
        UIImage(named: "trash_profile")
    ]
    
    var userData : UserDM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profil"
        navigationItem.backButtonTitle = ""
        userData = Cache.getUser()
        API.getMe { data in
            self.userData = data
        }
    }



}

extension ProfileVC : UITableViewDelegate, UITableViewDataSource, ProfileTVCDelegate{
    func didEditButtonTapped() {
        print("Edit")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileImageTVC.getProfileImageTVCID, for: indexPath) as! ProfileImageTVC
            cell.delegate = self
            cell.updateCell(userData: userData)
            return cell
        }else{
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.selectionStyle = .none
            cell.textLabel!.text = data[indexPath.row - 1]
            cell.imageView!.image = cellImages[indexPath.row - 1]
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return CGFloat(self.view.frame.height * 0.2)
        }else{
            return 70
        }
    }
}
