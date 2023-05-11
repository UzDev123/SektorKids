//
//  CallLogsTVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 25/04/23.
//

import UIKit

class CallLogsTVC: UITableViewCell {
    static var ID: String {
        "CallLogsTVCID"
    }
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func updateCell(data: CallLogsDM){

        dateAndTimeLabel.text = UIViewController.convertDateFormat(inputDate: data.callTime)
        nameLabel.text = data.name.isEmpty ? data.phoneNumber : data.name
        imgView.image = data.callType == "incoming" ? UIImage(named: "incoming_calls")! : UIImage(named: "outgoing_calls")!
        
    }
}
