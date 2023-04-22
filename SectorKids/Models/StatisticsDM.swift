//
//  StatisticsDM.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 19/04/23.
//

import UIKit
import SwiftyJSON

struct StatisticsDM{
    var id : Int
    var date : String
    var icon : String
    var day : Int
    var usagePercentage : Int
    var usageDuration : String
    var appName : String
    
    init(json: JSON){
        id = json["id"].intValue
        date = json["date"].stringValue
        icon = json["icon"].stringValue
        day = json["day"].intValue
        usagePercentage = json["usagePercentage"].intValue
        usageDuration = json["usageDuration"].stringValue
        appName = json["appName"].stringValue
    }
}
