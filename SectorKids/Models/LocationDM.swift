//
//  LocationDM.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 19/04/23.
//

import UIKit
import SwiftyJSON

struct LocationDM{
    var id :Int
    var latitude: String
    var longitude: String
    var date: String
    var addressName: String
    init(json: JSON){
        id = json["id"].intValue
        latitude = json["latitude"].stringValue
        longitude = json["longitude"].stringValue
        date = json["date"].stringValue
        addressName = json["addressName"].stringValue
    }
}
