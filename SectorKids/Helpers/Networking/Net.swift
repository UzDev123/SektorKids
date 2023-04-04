//
//  Net.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 03/04/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class Net{
    class func request(url: String, method: HTTPMethod, params: [String:Any]?, headers: HTTPHeaders?, withLoader: Bool, completion: @escaping (JSON?)->Void, success: @escaping (Bool) -> Void) {
        if Reachability.isConnectedToNetwork() {
            if withLoader {
                Loader.start()
            }
            
            AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
                Loader.stop()
                guard let data = response.data else {
                    completion(nil)
                    Alert.showAlert(forState: .error, message: "Unknown error occured, please try again later.", vibrationType: .error)
                    
                    return
                }
                if let code = response.response?.statusCode {
                    
                    switch code{
                    case 200...299:
                        //success
                        let json = JSON(data)
                        completion(json)
                        success(true)
                    case 400...499:
                        //user error
                        let json = JSON(data)
                        Alert.showAlert(forState: .error, message: "\(json["message"].stringValue)", vibrationType: .error)
                        success(false)
                    case 500...599:
                        //server error
                        let json = JSON(data)
                        Alert.showAlert(forState: .error, message: "\(json["message"].stringValue)", vibrationType: .error)
                        success(false)
                    default:
                        break
                    }
                }

                print("URL REQUEST: ", response.request ?? "")
                print("URL HEADER: ", response.response?.headers ?? "")
                print("RESPONSE DATA: ", JSON(data))
              
            }
        } else {
            //Not connected to the internet
            completion(nil)
            Alert.showAlert(forState: .error, message: "No internet connection", vibrationType: .error, duration: 2, userInteration: true)
            
        }
        
        
    }

}
