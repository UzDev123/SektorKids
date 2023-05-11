//
//  Extensions.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 16/03/23.
//

import UIKit


//MARK: -  UIFONT
extension UIFont{
    
    static func font(name: SectorKidsFont, size: SectorKidsFontSize) -> UIFont {
        UIFont.init(name: name.rawValue, size: .relative(for: size)) ?? .systemFont(ofSize: .relative(for: size))
    }
    
}

//MARK: - UITextField
extension UITextField{
    func setIconLeft(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 15, y: 12.5, width: 15, height: 15))
        iconView.contentMode = .scaleAspectFit
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 43, height: 40))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    func setEyeButton(_ image: UIImage){
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let bt = UIButton(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        bt.setImage(image, for: .normal)
        bt.addTarget(self, action: #selector(eye_tapped(_:)), for: .touchUpInside)
        iconView.addSubview(bt)
        rightView = iconView
        rightViewMode = .always
    }
    
    @objc func eye_tapped(_ button: UIButton){
        isSecureTextEntry = !isSecureTextEntry
        setEyeButton(self.isSecureTextEntry ? (UIImage(named: "invisible") ?? UIImage()) : (UIImage(named: "visible") ?? UIImage()))
    }
    
}

//MARK: - UIView
extension UIView {
    
    func addShadow(offset: CGSize, color: CGColor, radius: CGFloat, opacity: Float){
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color
    }
}

//MARK: - UITAPGESTURERECOGNIZER
extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textBoundingBox = layoutManager.boundingRect(forGlyphRange: targetRange, in: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

//MARK: - Userdefaults
public extension UserDefaults {

    /// Set Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    func set<T: Codable>(object: T, forKey: String) throws {

        let jsonData = try JSONEncoder().encode(object)

        set(jsonData, forKey: forKey)
    }

    /// Get Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {

        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }

        return try JSONDecoder().decode(objectType, from: result)
    }
    
}
//MARK: - SEGMENTED CONTROL
extension UISegmentedControl {

    /// Replace the current segments with new ones using a given sequence of string.
    /// - parameter withTitles:     The titles for the new segments.
    public func replaceSegments<T: Sequence>(withTitles: T) where T.Iterator.Element == String {
        removeAllSegments()
        for title in withTitles {
            insertSegment(withTitle: title, at: numberOfSegments, animated: false)
        }
    }
}



extension UIViewController{
    static func convertDateFormat(inputDate: String) -> String {
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = formatter.date(from: inputDate) {
            let convertDateFormatter = DateFormatter()
            convertDateFormatter.timeZone = .current
            convertDateFormatter.dateFormat = "h:mm a, dd-MMM, yyyy"
            return convertDateFormatter.string(from:date)
        }else{
            return ""
        }

    }
    
    static func getDateFromUnixStamp(inputDate: String) -> String{
        let interval = Int(inputDate) ?? 0
        let date = Date(timeIntervalSince1970: TimeInterval(interval))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a, dd-MMM, yyyy"
        let str = formatter.string(from: date)
        return str
    }
    
}
