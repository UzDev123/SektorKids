//
//  SMSDM.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 19/04/23.
//

import UIKit
import SwiftyJSON

struct SMSDM{
    var id : Int
    var msg: String
    var address: String
    ///inbox, outbox
    var type: String
    var createdAt : String
    var hash :String
    var date: String
    var updatedAt:String
    
    init(json: JSON){
        id = json["id"].intValue
        msg = json["msg"].stringValue
        address = json["address"].stringValue
        type = json["type"].stringValue
        createdAt = json["createdAt"].stringValue
        hash = json["hash"].stringValue
        date = json["date"].stringValue
        updatedAt = json["updatedAt"].stringValue
    }
}
