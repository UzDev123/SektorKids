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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var userData : UserDM?
    var contactData : [ContactDM] = [
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567"),
        ContactDM(name: "Someone", phone: "+998901234567")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kontaktlar"
        setupNavBarAndSegmentedControl()
    }
    
    private func setupNavBarAndSegmentedControl(){
        self.segmentedControl.removeAllSegments()
        if let userData = userData {
            for i in userData.children.enumerated() {
                self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
            }
            self.segmentedControl.selectedSegmentIndex = 0
        }
        API.getMe { data in
            self.userData = data
            if self.segmentedControl.numberOfSegments < self.userData!.children.count {
                for i in self.userData!.children.enumerated() {
                    self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
                }
                self.segmentedControl.selectedSegmentIndex = 0
            }
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
}
