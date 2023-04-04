//
//  ChartView.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 25/03/23.
//

import UIKit
class CircleChartView: UIView {
    var data: [CGFloat] = [] // This array holds the data to be displayed
    var colors: [UIColor] = [] // This array holds the colors for each data point
    var strokeWidth: CGFloat = 15.0 // The width of the chart's stroke
    let startAngle: CGFloat = -.pi/2 // The starting angle of the chart
    let animationDuration: CFTimeInterval = 1.0 // The duration of the animation
    public let label = UILabel()
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // Add the label as a subview of the circle chart view
            label.textColor = .black
//            label.font = .font(name: .roboto_regular, size: .r10)
            label.numberOfLines = 0
            label.textAlignment = .center
            addSubview(label)
        }
    
    override func draw(_ rect: CGRect) {
        // Calculate the center of the view and the radius of the chart
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height)/2 - strokeWidth/2
        
        // Draw the chart
        var currentAngle = startAngle
        for (index, value) in data.enumerated() {
            // Calculate the end angle of the arc
            let endAngle = currentAngle + 2 * .pi * value
            
            // Create the arc path
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: currentAngle, endAngle: endAngle, clockwise: true)
            
            // Create a CAShapeLayer for the arc
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.lineWidth = strokeWidth
            shapeLayer.lineCap = .round
            shapeLayer.strokeColor = colors[index % colors.count].cgColor
            shapeLayer.fillColor = UIColor.clear.cgColor
            layer.addSublayer(shapeLayer)
            
            // Add animation to the shape layer
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = animationDuration
            shapeLayer.add(animation, forKey: "strokeEndAnimation")
            
            // Update the current angle
            currentAngle = endAngle
            
            // Update the label's frame and text value
//            label.text = "75%" // You can update this value based on your data
            label.frame = CGRect(x: 0, y: 0, width: radius, height: radius)
            label.center = center
        }
    }
    
}

