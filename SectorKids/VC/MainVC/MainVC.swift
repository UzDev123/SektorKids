//
//  MainVC.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 15/03/23.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var topView: UIView!{
        didSet{
            topView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var childImageView: UIImageView!
    
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var childLastSeenLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private var chartView = CircleChartView()
    var userData : UserDM?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        segmentedControl.removeAllSegments()
        MySocket.default.listenSOS()
        print(Cache.getUserToken(), 111)
    }
    override func viewWillAppear(_ animated: Bool) {
        childNameLabel.text = ""
        childLastSeenLabel.text = ""
        API.getMe { userDM in
            //
            self.userData = userDM
            self.childNameLabel.text = userDM.children.first?.name ?? "No name"
            if let child = userDM.children.first{
                self.childLastSeenLabel.text = child.last_seen.isEmpty ? "1 daqiqa avval" : child.last_seen
            }
            
            if self.segmentedControl.numberOfSegments < userDM.children.count {
                self.segmentedControl.removeAllSegments()
                for i in userDM.children.enumerated() {
                    self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: true)
                }
                self.segmentedControl.selectedSegmentIndex = 0
            }
        }
    }
    override func viewDidLayoutSubviews() {
        chartView = CircleChartView(frame: CGRect(x: 10, y: 10, width: self.topView.frame.height - 20, height: self.topView.frame.height - 20))
        chartView.strokeWidth = self.topView.frame.height > 120 ? 20 : 15
        chartView.backgroundColor = .clear
        // Set the data and colors for the chart
        chartView.data = [0.4, 0.3, 0.2, 0.1]
        chartView.colors = [.red, .blue, .green, .yellow]
        chartView.label.font = self.topView.frame.height > 120 ? .font(name: .roboto_regular, size: .r16) : .font(name: .roboto_regular, size:.r14)
        chartView.label.text = "6 soat 30 daqiqa"
        self.topView.addSubview(chartView)
        
        childImageView.layer.cornerRadius = childImageView.frame.height / 2
       
    }
   
    private func setupNavBar(){
        title = "Sector Kids"
        navigationItem.backButtonTitle = ""
        let addButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(addButtonTapped))
       navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped(){
       let vc = CreateChildVC(nibName: "CreateChildVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func notEnabledButtonsTapped(_ sender: UIButton) {
        Alert.showAlert(forState: .warning, message: "Hozirda bu imkoniyat mavjud emas.", vibrationType: .warning)
    }
    
    
    @IBAction func sosTapped(_ sender: UIButton) {
        let vc = SOSVC(nibName: "SOSVC", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func microphoneButtonTapped(_ sender: UIButton) {
        let vc = RecordListVC(nibName: "RecordListVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func segmentToggled(_ sender: UISegmentedControl) {
        
        if let userData = userData{
            self.childNameLabel.text = userData.children[self.segmentedControl.selectedSegmentIndex].name
            self.childLastSeenLabel.text = userData.children[self.segmentedControl.selectedSegmentIndex].last_seen.isEmpty ? "1 daqiqa avval" : userData.children[self.segmentedControl.selectedSegmentIndex].last_seen
        }
    }
    
    
    @IBAction func animatetapped(_ sender: Any) {
        chartView.backgroundColor = .clear

        // Set the data and colors for the chart
        chartView.data = [0.4, 0.3, 0.2, 0.1]
        chartView.colors = [.red, .blue, .green, .yellow]
        chartView.label.text = "as"
        view.addSubview(chartView)
        
        

    }
    
}




