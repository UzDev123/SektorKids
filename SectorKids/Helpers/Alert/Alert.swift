
import UIKit
import AudioToolbox
let screenSize = UIScreen.main.bounds

class Alert {
    
    enum AlertType {
        case warning
        case success
        case error
        case unknown
    }
    
    static var timer : Timer? = nil
    
    class func showAlert(forState: AlertType, message: String, vibrationType: Vibration, duration: TimeInterval = 4, userInteration: Bool = true) {
                
        let view = UIView(frame: CGRect(x: 10, y: -90, width: screenSize.width-20, height: 65))
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.addShadow(offset: CGSize(width: 0, height: 0), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), radius: 3, opacity: 0.4)
        view.backgroundColor = .white
        
        
        let titleLbl = UILabel()
        titleLbl.frame = view.frame
        titleLbl.textColor = .white
        titleLbl.minimumScaleFactor = 8
        titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.textAlignment = .center
        
        titleLbl.numberOfLines = 3
        titleLbl.font = UIFont(name: "Inter-Medium", size: 15)

        view.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        titleLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true

        view.tag = 9981
        
        if let window = UIApplication.shared.keyWindow {
            if let vi = UIApplication.shared.keyWindow?.viewWithTag(9981) {
                timer?.invalidate()
                vi.removeFromSuperview()
            }
            window.addSubview(view)
            vibrate(type: vibrationType)
            
        }
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseIn, animations: {
            view.transform = CGAffineTransform(translationX: 0, y: 90+UIApplication.shared.statusBarFrame.size.height)
        })
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(closeBtnPressed))
        swipeLeft.direction = .up
        view.addGestureRecognizer(swipeLeft)
        
        titleLbl.text = message
        
        switch forState {
        case .warning:
            view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case .error:
            view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        case .success:
            view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case .unknown:
            view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(Alert.closeBtnPressed), userInfo: nil, repeats: false)        
    }
    
    @objc class func closeBtnPressed() {
        timer?.invalidate()
        if let window = UIApplication.shared.keyWindow, let view = window.viewWithTag(9981) {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
                view.transform = .identity
            }) { (_) in
                view.removeFromSuperview()
            }
        }
    }
    
    private class func vibrate(type: Vibration){
        switch type {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .soft:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
        case .rigid:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .oldSchool:
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
}
