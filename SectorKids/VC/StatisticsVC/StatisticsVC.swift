//
//  StatisticsVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 16/03/23.
//

import UIKit

class StatisticsVC: UIViewController {
    @IBOutlet weak var childStackView: UIStackView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "StatisticsTVC", bundle: nil), forCellReuseIdentifier: StatisticsTVC.ID)
        }
    }
    @IBOutlet weak var childNameLabel: UILabel!
    
    private var chartView = CircleChartView()
    var user_children : [ChildDM]! = Cache.getChildren()
    var last_selected_child_index = 0
    var data = [StatisticsDM]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Statistika"
        setupUserInfoAndSegmentedControl()
    }
    override func viewWillAppear(_ animated: Bool) {
        segmentedControl.selectedSegmentIndex = last_selected_child_index
        if let user_children = user_children{
            if !user_children.isEmpty {
                print(segmentedControl.selectedSegmentIndex,last_selected_child_index)
                API.getAppUsages(child_id: user_children[last_selected_child_index].id) { data in
                    self.data = data
                    self.tableView.reloadData()
                }
            }
        }
        chartView = CircleChartView(frame: CGRect(x:20 , y: childStackView.frame.height + 30, width: self.topView.frame.height - childStackView.frame.height - 50, height: self.topView.frame.height - childStackView.frame.height - 50))
        chartView.strokeWidth = self.topView.frame.height > 120 ? 20 : 15
        chartView.backgroundColor = .clear
        // Set the data and colors for the chart
        chartView.data = [0.4, 0.3, 0.2, 0.1]
        chartView.colors = [.red, .blue, .green, .yellow]
        chartView.label.font = self.topView.frame.height > 180 ? .font(name: .roboto_regular, size: .r14) : .font(name: .roboto_regular, size:.r12)
        chartView.label.text = "6 soat 30 daqiqa"
        self.topView.addSubview(chartView)
    }
    override func viewDidDisappear(_ animated: Bool) {
        chartView.removeFromSuperview()
    }
    
    
    
    //MARK: - Setup UI and SegmentControl
    private func setupUserInfoAndSegmentedControl(){
        self.segmentedControl.removeAllSegments()
        self.segmentedControl.selectedSegmentIndex = last_selected_child_index
        API.getMyChildren { data in
            self.user_children = data
            for i in self.user_children.enumerated() {
                self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
            }
            if !self.user_children.isEmpty{
                self.segmentedControl.selectedSegmentIndex = self.last_selected_child_index
                self.childNameLabel.text = self.user_children[self.segmentedControl.selectedSegmentIndex].name
            }
        }
    }
    @IBAction func segmentedControlToggled(_ sender: UISegmentedControl) {
        if !user_children.isEmpty {
            last_selected_child_index = segmentedControl.selectedSegmentIndex
            API.getAppUsages(child_id: user_children![last_selected_child_index].id) { data in
                self.data = data
                self.tableView.reloadData()
            }
        }
    }
    
}


extension StatisticsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTVC.ID, for: indexPath) as! StatisticsTVC
        cell.updateCell(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
