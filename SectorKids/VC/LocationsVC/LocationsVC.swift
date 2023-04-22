//
//  LocationsVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 14/04/23.
//

import UIKit
import MapKit

class LocationsVC: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "LocationsTVC", bundle: nil), forCellReuseIdentifier: LocationsTVC.ID)
        }
    }
    
    var user_children: [ChildDM]? = Cache.getChildren()
    var locationsData : [LocationDM] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        setupNavBarAndSegmentedControl()
        
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
            API.getLocations(child_id: user_children[segmentedControl.selectedSegmentIndex].id) { data in
                self.locationsData = data
                self.tableView.reloadData()
            }
        }
       
    }
  
}

extension LocationsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationsTVC.ID, for: indexPath) as! LocationsTVC
        cell.updateCell(data: locationsData[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
