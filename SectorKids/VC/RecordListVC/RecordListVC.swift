//
//  RecordListVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 05/04/23.
//

import UIKit

class RecordListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "RecordListTVC", bundle: nil), forCellReuseIdentifier: RecordListTVC.ID)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yozuvlar"
        navigationItem.backButtonTitle = ""
        
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
