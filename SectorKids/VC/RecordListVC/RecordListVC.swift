//
//  RecordListVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 05/04/23.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yozuvlar"
        navigationItem.backButtonTitle = ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "refresh"), style: .done, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.217478931, green: 0.2878425121, blue: 0.3411255479, alpha: 1)
        setupNavBarAndSegmentedControl()
        API.getRecordings(child_id: user_children![segmentedControl.selectedSegmentIndex].id)
    }

    @objc func refreshTapped(){
        
    }
    
    private func setupNavBarAndSegmentedControl(){
        self.segmentedControl.removeAllSegments()
        if let user_children = user_children {
            for i in user_children.enumerated() {
                self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
            }
            self.segmentedControl.selectedSegmentIndex = 0
        }
        
        if let user_children = user_children {
            MySocket.default.sendCommand(childID: user_children[self.segmentedControl.selectedSegmentIndex].id, command: "MICROPHONE", params: "")
        }
    }

}


extension RecordListVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordListTVC.ID, for: indexPath) as! RecordListTVC
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
}
extension RecordListVC : RecordListTVCDelegate{
    func didPlayPauseButtonToggled() {
        
    }
    
    
}
