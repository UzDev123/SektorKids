//
//  UserDM.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 03/04/23.
//

import UIKit
import SwiftyJSON
struct UserDM : Codable{
    var id : Int
    var name : String
    var phone: String
    var info: String
    var deviceInfo: String
    var created_at:String
    var updated_at :String
    var passport: String
    var inps:String
    var children  : [Child]
    init(json:JSON){
        id = json["id"].intValue
        name = json["name"].stringValue
        phone = json["phone"].stringValue
        info = json["phone"].stringValue
        deviceInfo = json["deviceInfo"].stringValue
        created_at = json["createdAt"].stringValue
        updated_at = json["updatedAt"].stringValue
        passport = json["passport"].stringValue
        inps = json["inps"].stringValue
        var childrenArr = [Child]()
        for i in json["children"].arrayValue{
            let child = Child(json: i)
            childrenArr.append(child)
        }
        self.children = childrenArr
    }
}

struct Child :Codable{
    var id: Int
    var name: String
    var gender : String
    var age: Int
    var phone: String
    var avatar :String
    var last_seen :String
    var info :String
    var secret :String
    var deviceInfo :String
    var createdAt: String
    var updatedAt:  String
    var imei:String
    var permissions:String
    var isOnline: Bool
    var token: String
    var commandQueue :String
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        gender = json["gender"].stringValue
        age = json["age"].intValue
        phone = json["phone"].stringValue
        avatar = json["avatar"].stringValue
        last_seen = json["last_seen"].stringValue
        info = json["info"].stringValue
        secret = json["secret"].stringValue
        deviceInfo = json["deviceInfo"].stringValue
        createdAt = json["createdAt"].stringValue
        updatedAt = json["updatedAt"].stringValue
        imei = json["imei"].stringValue
        permissions = json["permissions"].stringValue
        isOnline = json["isOnline"].boolValue
        token = json["token"].stringValue
        commandQueue = json["commandQueue"].stringValue
    }
}
