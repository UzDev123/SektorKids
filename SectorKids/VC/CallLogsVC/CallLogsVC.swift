//
//  CallLogsVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 25/04/23.
//

import UIKit

class CallLogsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CallLogsTVC", bundle: nil), forCellReuseIdentifier: CallLogsTVC.ID)
        }
    }
    var data = [CallLogsDM]()
    var child_id: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Qo'ng'iroqlar tarixi"
        API.getCallLogs(child_id: child_id) { data in
            self.data = data
            self.tableView.reloadData()
        }
    }


}
extension CallLogsVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CallLogsTVC.ID, for: indexPath) as? CallLogsTVC else{return UITableViewCell()}
        cell.updateCell(data: data[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phoneNumber = data[indexPath.row].phoneNumber
        let numberUrl = URL(string: "tel://\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(numberUrl) {
            UIApplication.shared.open(numberUrl)
        }
    }
}
