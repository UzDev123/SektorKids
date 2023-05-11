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
        "Call center",
        "Biz haqimizda",
        "Sozlamalar",
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
        guard let userData = userData else{return}
        let alert = UIAlertController(title: "Profilni tahrirlash", message: "Ismingizni o'zgartirishingiz mumkin.", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Saqlash", style: .default) { _ in
            let new_name :String = alert.textFields!.first!.text!
            API.editProfile(parent_id: userData.id, name: new_name) { success in
                API.getMe { data in
                    self.userData = data
                    self.tableView.reloadData()
                }
            }
            
        }
        let cancel = UIAlertAction(title: "Bekor qilish", style: .cancel)
        alert.addTextField { txt in
            txt.placeholder = "Yangi ismni kiriting"
            txt.font = .font(name: .roboto_regular, size: .r14)
        }
        alert.addAction(save)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
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
        if let id = Cache.getUser()?.id {
            if indexPath.row == data.count{
                let alert = UIAlertController(title: "Profilni o'chirish", message: "Haqiqatdan ham tizimdan profilingizni o'chirishni istaysizmi? O'chirilganidan so'ng, qayta tiklab bo'lmaydi.", preferredStyle: .alert)
                
                let delete = UIAlertAction(title: "O'chirish", style: .destructive) { _ in
                    API.deleteProfil(parent_id: id) { success in
                        if let window = UIApplication.shared.keyWindow{
                            Cache.saveUserToken(token: "")
                            Cache.saveChildren(children: nil)
                            window.rootViewController = UINavigationController(rootViewController:  WelcomeVC(nibName: "WelcomeVC", bundle: nil))
                            window.makeKeyAndVisible()
                        }
                    }
                }
                let cancel = UIAlertAction(title: "Bekor qilish", style: .cancel)
                
                alert.addAction(delete)
                alert.addAction(cancel)
                
                self.present(alert, animated: true)
            }
            if indexPath.row == data.count - 1{
                
                if let window = UIApplication.shared.keyWindow{
                    Cache.saveUser(user: nil)
                    Cache.saveUserToken(token: "")
                    Cache.saveChildren(children: nil)
                    window.rootViewController = UINavigationController(rootViewController:  WelcomeVC(nibName: "WelcomeVC", bundle: nil))
                    window.makeKeyAndVisible()
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return CGFloat(self.view.frame.height * 0.2)
        }else{
            return 70
        }
    }
}
