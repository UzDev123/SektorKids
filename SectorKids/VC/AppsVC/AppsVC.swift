//
//  AppsVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 13/04/23.
//

import UIKit

class AppsVC: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "AppsTVC", bundle: nil), forCellReuseIdentifier: AppsTVC.ID)
        }
    }
    var userData: UserDM? = Cache.getUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ilovalar"
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

extension AppsVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppsTVC.ID, for: indexPath) as! AppsTVC
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
