//
//  RecordingDM.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 28/04/23.
//

import UIKit
import SwiftyJSON
struct RecordingDM{
    var id: Int
    var name: String
    var path: String
    var size : String
    var date :String
    var isPlaying = false
    init(json: JSON){
        id = json["id"].intValue
        name = json["name"].stringValue
        path = json["path"].stringValue.replacingOccurrences(of: "\\", with: "")
        size = json["size"].stringValue
        date = json["date"].stringValue
        isPlaying = false
    }
}
