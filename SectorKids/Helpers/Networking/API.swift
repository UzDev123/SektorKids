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
        static let re_generate_code :String = API.baseURL + "/children/get/secret"
        static let children :String = API.baseURL + "/parent/children"
        static let delete_profile : String = API.baseURL + "/parent/delete"
        static let edit_profile : String = API.baseURL + "/parent/update"
        static let get_sms :String = API.baseURL + "/parent/child-sms"
        static let get_call_logs : String = API.baseURL + "/parent/child-calls"
        static let get_recordings : String = API.baseURL + "/parent/child-microphones"
        static let get_locations : String = API.baseURL + "/parent/child-locations"
        static let get_contancts : String = API.baseURL + "/parent/child-contacts"
        static let get_app_usages : String = API.baseURL + "/parent/child-app-usages"
    }
    
    private static let header : HTTPHeaders = ["Authorization" : "Bearer \(Cache.getUserToken())"]
    
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
        } success: { success in
            getMe { data in
                completion(success)
            }
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
    
    class func get_new_code(child_id: Int, completion: @escaping (String) -> Void){
        let headers : HTTPHeaders = ["Authorization" : "Bearer \(Cache.getUserToken())"]
        Net.request(url: Endpoints.re_generate_code + "?child_id=\(child_id)", method: .get, params: nil, headers: headers, withLoader: true) { data in
            if let data = data{
                completion("\(data["secret"].intValue)")
            }
        } success: { success in
            
        }

    }
    
    class func getMyChildren(completion : @escaping ([ChildDM]) -> Void){
        Net.request(url: Endpoints.children, method: .get, params: nil, headers: header, withLoader: false) { data in
            guard let data = data else{return}
            var children = [ChildDM]()
            for i in data.arrayValue {
                let child = ChildDM(json: i)
                children.append(child)
            }
            Cache.saveChildren(children: children)
            completion(children)
        } success: { success in
            
        }

    }
    
    class func deleteProfil(parent_id: Int, completion: @escaping (Bool)-> Void){
        Net.request(url: Endpoints.delete_profile + "/\(parent_id)", method: .delete, params: nil, headers: header, withLoader: true) { data in
            
        } success: { success in
            completion(success)
        }

    }
    
    class func editProfile(parent_id: Int, name: String, completion: @escaping (Bool) -> Void){
        let param = ["name" : name]
        Net.request(url: Endpoints.edit_profile + "/\(parent_id)", method: .put, params: param, headers: header, withLoader: true) { data in
            
        } success: { success in
            completion(success)
        }

    }
    
    class func getSMS(child_id: Int, completion: @escaping ([SMSDM]) -> Void ){
        Net.request(url: Endpoints.get_sms + "/\(child_id)", method: .get, params: nil, headers: header, withLoader: true) { data in
            guard let data = data else{return}
            var messages = [SMSDM]()
            for i in data.arrayValue {
                let msg = SMSDM(json: i)
                messages.append(msg)
            }
            completion(messages)
        } success: { success in
            
        }
    }
    class func getCallLogs(child_id: Int, completion: @escaping ([CallLogsDM]) -> Void ){
        Net.request(url: Endpoints.get_call_logs + "/\(child_id)", method: .get, params: nil, headers: header, withLoader: true) { data in
            guard let data = data else{return}
            var call_logs = [CallLogsDM]()
            for i in data.arrayValue {
                let d = CallLogsDM(json: i)
                call_logs.append(d)
            }
            completion(call_logs)
        } success: { success in
            //
        }
    }
    class func getAppUsages(child_id: Int, completion: @escaping ([StatisticsDM]) -> Void ){
        Net.request(url: Endpoints.get_app_usages + "/\(child_id)", method: .get, params: nil, headers: header, withLoader: true) { data in
            guard let data = data else{return}
            var statArr = [StatisticsDM]()
            for i in data.arrayValue {
                let d = StatisticsDM(json: i)
                statArr.append(d)
            }
            completion(statArr)
        } success: { success in
            //
        }
    }
    class func getLocations(child_id: Int, completion: @escaping ([LocationDM]) -> Void ){
        Net.request(url: Endpoints.get_locations + "/\(child_id)", method: .get, params: nil, headers: header, withLoader: true) { data in
            guard let data = data else {return}
            var locations = [LocationDM]()
            for i in data.arrayValue{
                let l = LocationDM(json: i)
                locations.append(l)
            }
            completion(locations)
        } success: { success in
            //
        }
    }
    class func getRecordings(child_id: Int, completion: @escaping ([RecordingDM]) -> Void ){
        Net.request(url: Endpoints.get_recordings + "/\(child_id)", method: .get, params: nil, headers: header, withLoader: true) { data in
            guard let data = data else{return}
            var arr = [RecordingDM]()
            for i in data.arrayValue {
                arr.append(RecordingDM(json: i))
            }
            completion(arr)
        } success: { success in
            //
        }
    }
    class func getContacts(child_id: Int, completion: @escaping ([ContactDM]) -> Void ){
        Net.request(url: Endpoints.get_contancts + "/\(child_id)", method: .get, params: nil, headers: header, withLoader: true) { data in
            guard let data = data else{return}
            var contacts = [ContactDM]()
            for i in data.arrayValue {
                let contact = ContactDM(json: i)
                contacts.append(contact)
            }
            completion(contacts)
        } success: { success in
            //
        }
    }
}
