//
//  LocationsTVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 14/04/23.
//

import UIKit

class LocationsTVC: UITableViewCell {
    static var ID : String{
        "LocationsTVCID"
    }
    @IBOutlet weak var distanceAndDate: UILabel!
    @IBOutlet weak var locName: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func updateCell(data : LocationDM){
        locName.text = "\(data.id)"
        distanceAndDate.text = data.date.getFormattedDate(format: "dd-MM-yyyy HH:mm").getFormattedDate(format: "dd-MM-yyyy HH:mm")
        
    }
    
}
