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
    var last_selected_child_index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Manzillar"
        setupNavBarAndSegmentedControl()
        
    }
    
    private func setupNavBarAndSegmentedControl(){
        self.segmentedControl.removeAllSegments()
        if let user_children = user_children {
            for i in user_children.enumerated() {
                self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
            }
            self.segmentedControl.selectedSegmentIndex = last_selected_child_index
        }
        if let user_children = user_children {
            API.getLocations(child_id: user_children[segmentedControl.selectedSegmentIndex].id) { data in
                self.locationsData = data
                self.tableView.reloadData()
            }
        }
       
    }
    
    
    @IBAction func segmentControlToggled(_ sender: UISegmentedControl) {
        last_selected_child_index = segmentedControl.selectedSegmentIndex
        API.getLocations(child_id: user_children![last_selected_child_index].id) { data in
            self.locationsData = data
            self.tableView.reloadData()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MapVC(nibName: "MapVC", bundle: nil)
        vc.data = locationsData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
