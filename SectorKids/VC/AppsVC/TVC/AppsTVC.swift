//
//  AppsTVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 13/04/23.
//

import UIKit

class AppsTVC: UITableViewCell {
    static var ID : String {
        "AppsTVC"
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    func updateCell(){
        
    }
}
