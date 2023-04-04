//
//  Cache.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 03/04/23.
//

import UIKit

class Cache{
    
    class func saveUserToken(token : String){
        UserDefaults.standard.set(token, forKey: "USER.TOKEN")
    }
    
    class func getUserToken() -> String {
        UserDefaults.standard.string(forKey: "USER.TOKEN") ?? ""
    }
    
    class func saveUser(user:UserDM?){
        do {
            try UserDefaults.standard.set(object: user, forKey: "USERDM")
            
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    class func getUser() -> UserDM?{
        do {
            let data = (try UserDefaults.standard.get(objectType: UserDM.self, forKey: "USERDM"))
            return data
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
}

