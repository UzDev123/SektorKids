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
    
    init(json: JSON){
        id = json["id"].intValue
        latitude = json["latitude"].stringValue
        longitude = json["logitude"].stringValue
        date = json["date"].stringValue
    }
}
