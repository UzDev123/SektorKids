//
//  Contact.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 12/04/23.
//

import Foundation
import SwiftyJSON

struct ContactDM{
    var id: Int
    var contactName:String
    var phoneNumber: String
    var date : String
    
    init(json: JSON){
        id = json["id"].intValue
        contactName = json["contactName"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        date = json["date"].stringValue
    }
}
