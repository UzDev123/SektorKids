//
//  API.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 03/04/23.
//

import UIKit
import SwiftyJSON
import Alamofire

class API {
    
    public static let baseURL: String = "https://kids.datagaze-lab.uz/api"
    
    private struct Endpoints {
        static let register : String = API.baseURL + "/users-permissions/register_otp"
        static let login : String = API.baseURL + "/auth/local"
        static let otp_confirm : String = API.baseURL + "/users-permissions/register_confirm_otp"
        static let passport : String = API.baseURL + "/users-permissions/passport"
        static let getMe : String = API.baseURL + "/users/me"
        static let create_child : String = API.baseURL + "/children"
    }
    
    ///phone - with '+' sign, +998906319797
    class func register(phone : String, password : String, completion: @escaping
    (Bool) -> Void){
        
        let param = ["phone" : phone, "password" : password]
        
        Net.request(url: Endpoints.register, method: .post, params: param, headers: nil, withLoader: true) { data in
            guard let data = data else{return}
            
        } success: { success in
            completion(success)
        }

    }
    ///here phone without '+' sign, 998906319797
    class func send_otp(phone: String, otp: String, completion: @escaping (Bool) -> Void){
        let param = ["phone" : phone, "otp" : otp]
        
        Net.request(url: Endpoints.otp_confirm, method: .post, params: param, headers: nil, withLoader: true) { data in
            guard let data = data else{return}
            Cache.saveUserToken(token: data["jwt"].stringValue)
            
        } success: { isSuccess in
            completion(isSuccess)
        }

    }
    
    class func login(phone:String, password: String, completion: @escaping (Bool) -> Void){
        let param = ["identifier" : phone, "password" : password]
        
        
        Net.request(url: Endpoints.login, method: .post, params: param, headers: nil, withLoader: true) { data in
            guard  let data = data else{return}
            Cache.saveUserToken(token: data["jwt"].stringValue)
            getMe { data in
                //
            }
        } success: { success in
            completion(success)
        }

    }
    
    class func getMe(completion : @escaping (UserDM) -> Void){
        let headers : HTTPHeaders = ["Authorization" : "Bearer \(Cache.getUserToken())"]
        Net.request(url: Endpoints.getMe, method: .get, params: nil, headers: headers, withLoader: false) { data in
            //
            guard let data = data else{return}
            let user = UserDM(json: data["parent"])
            Cache.saveUser(user: user)
            completion(user)
        } success: { success in
            //
        }

    }
    
    class func create_child(name: String, age: Int, phone: String, secretCode: @escaping (String) -> Void, completion: @escaping (Bool) -> Void){
        let param : [String : Any] = ["name" : name, "age" : age, "phone" : phone, "parent" : Cache.getUser()?.id ?? 0]
        let headers : HTTPHeaders = ["Authorization" : "Bearer \(Cache.getUserToken())"]
        
        Net.request(url: Endpoints.create_child, method: .post, params: param, headers: headers, withLoader: true) { data in
            //
            guard let data = data else{return}
            secretCode(data["secret"].stringValue)
        } success: { success in
            completion(success)
        }

    }
    
}
