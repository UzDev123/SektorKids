//
//  RecordListTVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 05/04/23.
//

import UIKit
protocol RecordListTVCDelegate{
    func didPlayPauseButtonToggled()
}
class RecordListTVC: UITableViewCell {
    static var ID : String{
        return "RecordListTVCID"
    }
    var delegate: RecordListTVCDelegate?
    @IBOutlet weak var moreButtonTapped: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func updateCell(recordData: String){
        
    }
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        delegate?.didPlayPauseButtonToggled()
    }
}
