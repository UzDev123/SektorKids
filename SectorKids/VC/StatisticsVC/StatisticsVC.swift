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
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Statistika"
        setupUserInfoAndSegmentedControl()
        API.getAppUsages(child_id: user_children![segmentedControl.selectedSegmentIndex].id)
    }
    
    override func viewDidLayoutSubviews() {
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
    
    //MARK: - Setup UI and SegmentControl
    private func setupUserInfoAndSegmentedControl(){
        self.segmentedControl.removeAllSegments()
        if let user_children = user_children{
            if !user_children.isEmpty{
                for i in user_children.enumerated() {
                    self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
                }
                self.segmentedControl.selectedSegmentIndex = 0
                self.childNameLabel.text = user_children[segmentedControl.selectedSegmentIndex].name
            }
        }
    }
}


extension StatisticsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTVC.ID, for: indexPath) as! StatisticsTVC
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
