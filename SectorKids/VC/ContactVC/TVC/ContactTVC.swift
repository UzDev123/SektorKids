//
//  ContactTVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 12/04/23.
//

import UIKit

class ContactTVC: UITableViewCell {
    static var ID : String{
        return "ContactTVCID"
    }
    
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var phone_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    func updateCell(data:ContactDM){
        name_label.text = data.contactName
        phone_label.text = data.phoneNumber
    }
  
    
}
