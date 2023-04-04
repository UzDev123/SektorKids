//
//  Enums.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 16/03/23.
//

import UIKit

enum SectorKidsFont: String {
    case roboto_black = "Roboto-Black"
    case roboto_black_italic = "Roboto-BlackItalic"
    case roboto_bold = "Roboto-Bold"
    case roboto_bold_italic = "Roboto-BoldItalic"
    case roboto_italic = "Roboto-Italic"
    case roboto_light = "Roboto-Light"
    case roboto_light_italic = "Roboto-LightItalic"
    case roboto_medium = "Roboto-Medium"
    case roboto_medium_italic = "Roboto-MediumItalic"
    case roboto_regular = "Roboto-Regular"
    case roboto_thin = "Roboto-Thin"
    case roboto_thinItalic = "Roboto-ThinItalic"
}

///375/812
enum SectorKidsFontSize {
    case r10
    case r12
    case r14
    case r15
    case r16
    case r18
    case r20
    case r22
    case r24
    case r28
    case r30
    case r36
    case r80
}

extension CGFloat {
    
    ///screen size
    static var scSize: CGSize = UIScreen.main.bounds.size.width > 375 ? CGSize(width: 375, height: 812) : UIScreen.main.bounds.size
    
    ///design size
    static var uiSize: CGSize = CGSize(width: 375, height: 812)
    
    ///getting relative size according to screen size
    static func relative(for size: SectorKidsFontSize) -> CGFloat {
        
        switch size {
        case .r10: return 10*scSize.width/uiSize.width
        case .r12: return 12*scSize.width/uiSize.width
        case .r14: return 14*scSize.width/uiSize.width
        case .r15: return 15*scSize.width/uiSize.width
        case .r16: return 16*scSize.width/uiSize.width
        case .r24: return 24*scSize.width/uiSize.width
        case .r20: return 20*scSize.width/uiSize.width
        case .r18: return 18*scSize.width/uiSize.width
        case .r22: return 22*scSize.width/uiSize.width
        case .r28: return 28*scSize.width/uiSize.width
        case .r30: return 30*scSize.width/uiSize.width
        case .r36: return 36*scSize.width/uiSize.width
        case .r80: return 80*scSize.width/uiSize.width
        }
        
    }
    
}
