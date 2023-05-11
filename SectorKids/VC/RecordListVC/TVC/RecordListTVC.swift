//
//  RecordListTVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 05/04/23.
//

import UIKit

protocol RecordListTVCDelegate{
    func didPlayPauseButtonToggled(data: RecordingDM, indexpath: IndexPath)
}
class RecordListTVC: UITableViewCell{
    static var ID : String{
        return "RecordListTVCID"
    }
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var delegate: RecordListTVCDelegate?
    @IBOutlet weak var moreButtonTapped: UIButton!
    var data: RecordingDM!
    var indexPath : IndexPath!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func updateCell(recordData: RecordingDM, indexPath: IndexPath){
        self.indexPath = indexPath
        data = recordData
        playPauseButton.setImage(recordData.isPlaying ? UIImage(named: "pause_recordList") : UIImage(named: "play_recordList"), for: .normal)
        nameLabel.text = recordData.name
        dateLabel.text = UIViewController.getDateFromUnixStamp(inputDate: recordData.date)
    }
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        delegate?.didPlayPauseButtonToggled(data: data, indexpath: indexPath)
    }
    
  

}
