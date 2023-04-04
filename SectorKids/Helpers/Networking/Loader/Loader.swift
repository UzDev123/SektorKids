//
//  Loader.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 03/04/23.
//

import UIKit
public class Loader {
    
    ///Shows custom Alert for a while
    class func start() {

        let loadV = UIView()
        loadV.tag = 19997
        loadV.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        loadV.frame = UIScreen.main.bounds
//        let customView = AnimationView()
//        customView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        let indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        indicatorView.style = .large
        indicatorView.startAnimating()
        loadV.addSubview(indicatorView)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.centerXAnchor.constraint(equalTo: loadV.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: loadV.centerYAnchor).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        UIApplication.shared.keyWindow?.addSubview(loadV)
        
    }
    
    
    
    class func stop() {
        for i in UIApplication.shared.keyWindow!.subviews {
            if i.tag == 19997 {
//                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
//                    i.backgroundColor = .clear
//                } completion: { (_) in
                    i.removeFromSuperview()
//                }
            }
        }
    }
}

