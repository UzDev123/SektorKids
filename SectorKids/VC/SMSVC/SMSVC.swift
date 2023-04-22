//
//  SMSVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 19/04/23.
//

import UIKit


class SMSVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "SMSTVC", bundle: nil), forCellReuseIdentifier: SMSTVC.ID)
        }
    }
    
    
    var smsData : [SMSDM] = []
    var child_id : Int! = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SMS xabarlar"
        getSMS(child_id: child_id)
    }
    
    private func getSMS(child_id: Int){
        API.getSMS(child_id: child_id) { data in
            self.smsData = data
            self.tableView.reloadData()
        }
    }


  

}

extension SMSVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        smsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SMSTVC.ID, for: indexPath) as? SMSTVC else {return UITableViewCell()}
        cell.updateCell(data: smsData[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
