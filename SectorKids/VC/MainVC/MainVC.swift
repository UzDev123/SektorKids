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
    ///agar bolalari bo'lmasa topview ni o'rnida ko'rinadiigan bolangizni qoshish uchun + ga bosing degan rasm
    @IBOutlet weak var addChildImageView: UIImageView!
    @IBOutlet weak var childImageView: UIImageView!
    
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var childLastSeenLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var newOtpView: UIView!
    @IBOutlet weak var newOtpDescLabel: UILabel!
    @IBOutlet weak var newOtpLabel: UILabel!
    
    private var chartView = CircleChartView()
    
    var user_children : [ChildDM]? = Cache.getChildren()
    ///Bu segment controlni qayta tog'irlash uchun kerak.
    var last_selected_children_index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarAndSegmentAndTopView()
        MySocket.default.listenSOS()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        API.getMyChildren {[self] children in
            self.topView.isHidden = children.isEmpty
            self.addChildImageView.isHidden = !self.topView.isHidden
            if !children.isEmpty {
                self.user_children = children
                self.segmentedControl.removeAllSegments()
                for i in children.enumerated() {
                    self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
                }
                self.segmentedControl.selectedSegmentIndex = self.last_selected_children_index
                self.childNameLabel.text = children[segmentedControl.selectedSegmentIndex].name
                self.childLastSeenLabel.text = children[segmentedControl.selectedSegmentIndex].last_seen
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
        self.topView.isHidden = true
        if let user_children = user_children{
            self.topView.isHidden = user_children.isEmpty
            self.addChildImageView.isHidden = !self.topView.isHidden
        }
        
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
            if !user_children.isEmpty{
                self.segmentedControl.selectedSegmentIndex = self.last_selected_children_index
                self.childNameLabel.text = user_children[segmentedControl.selectedSegmentIndex].name
                self.childLastSeenLabel.text = user_children[segmentedControl.selectedSegmentIndex].last_seen
            }
            
        }
        API.getMyChildren {[self] children in
            self.user_children = children
            if !self.user_children!.isEmpty{
                self.segmentedControl.removeAllSegments()
                for i in children.enumerated() {
                    self.segmentedControl.insertSegment(withTitle: i.element.name, at: i.offset, animated: false)
                }
                self.segmentedControl.selectedSegmentIndex = self.last_selected_children_index
                self.childNameLabel.text = children[segmentedControl.selectedSegmentIndex].name
                self.childLastSeenLabel.text = children[segmentedControl.selectedSegmentIndex].last_seen
            }
            
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
        if let user_children =  user_children{
            if !user_children.isEmpty{
                let vc = SOSVC(nibName: "SOSVC", bundle: nil)
                vc.user_children = user_children
                vc.last_selected_child_index = last_selected_children_index
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    @IBAction func microphoneButtonTapped(_ sender: UIButton) {
        if let user_children = user_children{
            if !user_children.isEmpty{
                let vc = RecordListVC(nibName: "RecordListVC", bundle: nil)
                vc.hidesBottomBarWhenPushed = true
                vc.user_children = user_children
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    @IBAction func contactsButtonTapped(_ sender: UIButton) {
        if let user_children = user_children{
            if !user_children.isEmpty{
                let vc = ContactVC(nibName: "ContactVC", bundle: nil)
                vc.hidesBottomBarWhenPushed = true
                vc.child_id = user_children[segmentedControl.selectedSegmentIndex].id
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    @IBAction func segmentToggled(_ sender: UISegmentedControl) {
        if let user_children = user_children{
            if !user_children.isEmpty{
                last_selected_children_index = self.segmentedControl.selectedSegmentIndex
                StatisticsVC().last_selected_child_index = last_selected_children_index
                self.childNameLabel.text = user_children[self.segmentedControl.selectedSegmentIndex].name
                self.childLastSeenLabel.text = user_children[self.segmentedControl.selectedSegmentIndex].last_seen.isEmpty ? "1 daqiqa avval" : user_children[self.segmentedControl.selectedSegmentIndex].last_seen
            }
            
        }
    }
    
    
    @IBAction func locationsTapped(_ sender: UIButton) {
        if let user_children = user_children{
            if !user_children.isEmpty{
                let vc = LocationsVC(nibName: "LocationsVC", bundle: nil)
                vc.user_children = user_children
                vc.last_selected_child_index = last_selected_children_index
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    @IBAction func appsButtonTapped(_ sender: UIButton) {
        if let user_children = user_children{
            if !user_children.isEmpty{
                let vc = AppsVC(nibName: "AppsVC", bundle: nil)
                vc.user_children = user_children
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    @IBAction func callLogsButtonTapped(_ sender: UIButton) {
        if let user_children = user_children{
            if !user_children.isEmpty{
                let vc = CallLogsVC(nibName: "CallLogsVC", bundle: nil)
                vc.child_id = user_children[last_selected_children_index].id
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func smsButtonTapped(_ sender: UIButton) {
        if let user_children = user_children{
            if !user_children.isEmpty{
                let vc = SMSVC(nibName: "SMSVC", bundle: nil)
                vc.hidesBottomBarWhenPushed = true
                vc.child_id = user_children[segmentedControl.selectedSegmentIndex].id
                navigationController?.pushViewController(vc, animated: true)
            }
            
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




