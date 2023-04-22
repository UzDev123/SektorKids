//
//  SMSTVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 19/04/23.
//

import UIKit

class SMSTVC: UITableViewCell {

    static var ID : String{
        return "SMSTVCID"
    }
    
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var phone_label: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    func updateCell(data: SMSDM){
        name_label.text = data.address
        phone_label.text = data.msg
        icon.image = data.type == "inbox" ?  UIImage(named: "sms_icon_in") : UIImage(named: "sms_icon_out") /*sms_icon_out*/
        dateLabel.text = data.date.getFormattedDate(format: "dd-MM-yy HH:mm").getFormattedDate(format: "yyyy-MM-dd HH:mm")
    }
  
}
