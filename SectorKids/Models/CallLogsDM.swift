//
//  CallLogsDM.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 25/04/23.
//

import UIKit
import SwiftyJSON

struct CallLogsDM{
    var id: Int
    var phoneNumber : String
    var name:String
    var callDuration: Int
    var callTime: String
    ///outcoming, incoming
    var callType: String
    
    init(json: JSON){
        id = json["id"].intValue
        phoneNumber = json["phoneNumber"].stringValue
        name = json["name"].stringValue
        callDuration = json["callDuration"].intValue
        callTime = json["callTime"].stringValue
        callType = json["callType"].stringValue
    }
}
