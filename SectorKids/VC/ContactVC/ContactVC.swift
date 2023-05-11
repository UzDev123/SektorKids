//
//  ContactVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 12/04/23.
//

import UIKit

class ContactVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ContactTVC", bundle: nil), forCellReuseIdentifier: ContactTVC.ID)
        }
    }
    
    var child_id : Int = -1
    var contactData : [ContactDM] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kontaktlar"
        getContacts(child_id: child_id)
    }

    func getContacts(child_id: Int){
        API.getContacts(child_id: child_id) { data in
            self.contactData = data
            self.tableView.reloadData()
        }
    }


  

}

extension ContactVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTVC.ID, for: indexPath) as? ContactTVC else {return UITableViewCell()}
        cell.updateCell(data: contactData[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phoneNumber = contactData[indexPath.row].phoneNumber
        let numberUrl = URL(string: "tel://\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(numberUrl) {
            UIApplication.shared.open(numberUrl)
        }
    }
}
