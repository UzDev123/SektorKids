//
//  MainTabbarVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 15/03/23.
//

import UIKit

class MainTabbarVC: UITabBarController {
    let mainVC = UINavigationController(rootViewController: MainVC(nibName: "MainVC", bundle: nil))
    let statisticsVC = UINavigationController(rootViewController: StatisticsVC(nibName: "StatisticsVC", bundle: nil))
    let profileVC = UINavigationController(rootViewController: ProfileVC(nibName: "ProfileVC", bundle: nil))
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        
        mainVC.title = "Asosiy"
        mainVC.tabBarItem.image = UIImage(named: "Main")
        
        statisticsVC.title = "Statistika"
        statisticsVC.tabBarItem.image = UIImage(named: "Statistics")
        
        profileVC.title = "Profil"
        profileVC.tabBarItem.image = UIImage(named: "Profile")
        self.tabBar.tintColor = #colorLiteral(red: 0.2766698003, green: 0.3586434424, blue: 0.41623348, alpha: 1)
        
        self.viewControllers = [mainVC, statisticsVC, profileVC]
        
    }

    

}
