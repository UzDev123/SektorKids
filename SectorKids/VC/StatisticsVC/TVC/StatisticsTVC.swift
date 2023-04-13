//
//  StatisticsTVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 13/04/23.
//

import UIKit

class StatisticsTVC: UITableViewCell {
    static var ID : String{
        "StatisticsTVCID"
    }
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var usageTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func updateCell(){
        
    }


}
