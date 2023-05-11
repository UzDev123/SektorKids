//
//  RecordListVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 05/04/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation
class RecordListVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "RecordListTVC", bundle: nil), forCellReuseIdentifier: RecordListTVC.ID)
        }
    }
    var user_children : [ChildDM]? = Cache.getChildren()
    var data : [RecordingDM] = []
    var last_seslected_child = 0
    var audioPlayer : AVAudioPlayer!
    var last_selected_audio_position : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yozuvlar"
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "refresh"), style: .done, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.217478931, green: 0.2878425121, blue: 0.3411255479, alpha: 1)
        setupNavBarAndSegmentedControl()
        
        API.getRecordings(child_id: user_children![segmentedControl.selectedSegmentIndex].id) { data in
            self.data = data
            self.tableView.reloadData()
        }
    }

    @objc func refreshTapped(){
        
    }
    
    private func setupNavBarAndSegmentedControl(){
        self.segmentedControl.removeAllSegments()
        if let user_children = user_children {
            for i in user_children.enumerated() {
                self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
            }
            self.segmentedControl.selectedSegmentIndex = last_seslected_child
        }
        
    }

}


extension RecordListVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordListTVC.ID, for: indexPath) as! RecordListTVC
        cell.delegate = self
        cell.updateCell(recordData: data[indexPath.row], indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    //MARK: - Download Audio
    private func downloadAudio(url: URL, indexPath : IndexPath){
          let task = URLSession.shared.downloadTask(with: url) { (url, response, error) in
              if error != nil{
                  print("Error")
              }else{
                  guard let url = url else {
                      print("Error: \(error?.localizedDescription ?? "Unknown error")")
                      return
                  }
                  do {
                      try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                      try AVAudioSession.sharedInstance().setActive(true)
                      self.audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: "mp3")
                      guard let audioPlayer = self.audioPlayer else { return }
                      
                      audioPlayer.delegate = self
                      audioPlayer.volume = 1.0
                      DispatchQueue.main.async { [weak self] in
                          guard let self = self else {return}
                          for i in data.enumerated() {
                              data[i.offset].isPlaying = false
                          }
                          audioPlayer.prepareToPlay()
                          audioPlayer.play()
                          data[indexPath.row].isPlaying = true
                          tableView.reloadData()
                          
                      }
                      
                  } catch {
                      print("ERROR WITH AUDIO PLAYER ⛔️, Couldn't set session")
                      DispatchQueue.main.async { [weak self] in
                          guard let self = self else {return}
                      }
                  }
              }
          
          }

          task.resume()
      }
    override func viewDidDisappear(_ animated: Bool) {
        if let _ = audioPlayer{
            audioPlayer.stop()
            audioPlayer = nil
        }
       
    }
    
}
extension RecordListVC : RecordListTVCDelegate, AVAudioPlayerDelegate{
    func didPlayPauseButtonToggled(data: RecordingDM, indexpath: IndexPath) {
        if let audioPlayer = audioPlayer {
            //obyekt bor, play yoki pause xolatda
            if indexpath.row == last_selected_audio_position{
                if audioPlayer.isPlaying{
                    audioPlayer.stop()
                    let cell = tableView.cellForRow(at: indexpath) as! RecordListTVC
                    cell.playPauseButton.setImage(UIImage(named: "play_recordList"), for: .normal)
                    
                }else{
                    audioPlayer.play()
                    let cell = tableView.cellForRow(at: indexpath) as! RecordListTVC
                    cell.playPauseButton.setImage(UIImage(named: "pause_recordList"), for: .normal)
                }
            }else{
                self.audioPlayer = nil
                downloadAudio(url: URL(string: "https://kids.datagaze-lab.uz/uploads" + data.path)!, indexPath: indexpath)
                last_selected_audio_position = indexpath.row
            }
        }else{
            //obyekt yoq, obyekt olib play qilish kerak.
            downloadAudio(url: URL(string: "https://kids.datagaze-lab.uz/uploads" + data.path)!, indexPath: indexpath)
            last_selected_audio_position = indexpath.row
        }
        
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
}
