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
    
    func updateCell(data: StatisticsDM){
        appName.text = data.appName
        usageTime.text = data.usageDuration + " daqiqa"
        imgView.image = data.icon.isEmpty ? UIImage(named: "placeholder_statistics_icon") : UIImage(named: "placeholder_statistics_icon")
    }


}
