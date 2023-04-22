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
    
    @IBOutlet weak var newOtpView: UIView!
    @IBOutlet weak var newOtpDescLabel: UILabel!
    @IBOutlet weak var newOtpLabel: UILabel!
    
    private var chartView = CircleChartView()
    
    var user_children : [ChildDM]? = Cache.getChildren()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarAndSegmentAndTopView()
        MySocket.default.listenSOS()
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        API.getMyChildren {[self] children in
            self.user_children = children
            self.segmentedControl.removeAllSegments()
            for i in children.enumerated() {
                self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
            }
            self.segmentedControl.selectedSegmentIndex = 0
            self.childNameLabel.text = children[segmentedControl.selectedSegmentIndex].name
            self.childLastSeenLabel.text = children[segmentedControl.selectedSegmentIndex].last_seen
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
    private func setupNavBarAndSegmentAndTopView(){
        title = "Sector Kids"
        navigationItem.backButtonTitle = ""
        let addButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(addButtonTapped))
       navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.217478931, green: 0.2878425121, blue: 0.3411255479, alpha: 1)
        
        newOtpView.isHidden = true
        newOtpView.transform = .init(scaleX: 0.1, y: 0.1)
        self.segmentedControl.removeAllSegments()
        if let user_children = user_children {
            self.segmentedControl.removeAllSegments()
            for i in user_children.enumerated() {
                self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
            }
            self.segmentedControl.selectedSegmentIndex = 0
            self.childNameLabel.text = user_children[segmentedControl.selectedSegmentIndex].name
            self.childLastSeenLabel.text = user_children[segmentedControl.selectedSegmentIndex].last_seen
        }
        API.getMyChildren {[self] children in
            self.user_children = children
            self.segmentedControl.removeAllSegments()
            for i in children.enumerated() {
                self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
            }
            self.segmentedControl.selectedSegmentIndex = 0
            self.childNameLabel.text = children[segmentedControl.selectedSegmentIndex].name
            self.childLastSeenLabel.text = children[segmentedControl.selectedSegmentIndex].last_seen
        }
    }
    
    
    
    
    @IBAction func getNewCodeTapped(_ sender: UIButton) {
        
        if let user_children = user_children {
            API.get_new_code(child_id: user_children[segmentedControl.selectedSegmentIndex].id) {[self] code in
                newOtpView.isHidden = false
                UIView.animate(withDuration: 0.3) {
                    self.newOtpView.transform = .identity
                } completion: {[self] _ in
                    newOtpDescLabel.text = "*\(user_children[segmentedControl.selectedSegmentIndex].name)ni qo'shish uchun, farzandingiz qurilmasida ushbu kodni kiriting."
                }
            }
        }
      
    }
    ///new opt view dismiss button
    @IBAction func xButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.newOtpView.transform = .init(scaleX: 0.1, y: 0.1)
        }completion: { _ in
            self.newOtpView.isHidden = true
        }
        
        
    }
    
    
    @objc func addButtonTapped(){
       let vc = CreateChildVC(nibName: "CreateChildVC", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func notEnabledButtonsTapped(_ sender: UIButton) {
        Alert.showAlert(forState: .warning, message: "Hozirda bu imkoniyat mavjud emas.", vibrationType: .warning)
    }
    @IBAction func sosTapped(_ sender: UIButton) {
        let vc = SOSVC(nibName: "SOSVC", bundle: nil)
        vc.user_children = user_children
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func microphoneButtonTapped(_ sender: UIButton) {
        let vc = RecordListVC(nibName: "RecordListVC", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        vc.user_children = user_children
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func contactsButtonTapped(_ sender: UIButton) {
        if let user_children = user_children {
            let vc = ContactVC(nibName: "ContactVC", bundle: nil)
            vc.hidesBottomBarWhenPushed = true
            vc.child_id = user_children[segmentedControl.selectedSegmentIndex].id
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @IBAction func segmentToggled(_ sender: UISegmentedControl) {
        if let user_children = user_children{
            self.childNameLabel.text = user_children[self.segmentedControl.selectedSegmentIndex].name
            self.childLastSeenLabel.text = user_children[self.segmentedControl.selectedSegmentIndex].last_seen.isEmpty ? "1 daqiqa avval" : user_children[self.segmentedControl.selectedSegmentIndex].last_seen
        }
    }
    

    @IBAction func locationsTapped(_ sender: UIButton) {
        let vc = LocationsVC(nibName: "LocationsVC", bundle: nil)
        vc.user_children = user_children
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func appsButtonTapped(_ sender: UIButton) {
        let vc = AppsVC(nibName: "AppsVC", bundle: nil)
        vc.user_children = user_children
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func callLogsButtonTapped(_ sender: UIButton) {
        API.getCallLogs(child_id: 19)
    }
    
    @IBAction func smsButtonTapped(_ sender: UIButton) {
        if let user_children = user_children{
            let vc = SMSVC(nibName: "SMSVC", bundle: nil)
            vc.hidesBottomBarWhenPushed = true
            vc.child_id = user_children[segmentedControl.selectedSegmentIndex].id
            navigationController?.pushViewController(vc, animated: true)
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




