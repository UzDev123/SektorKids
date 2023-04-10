//
//  Socket.swift
//  SectorKids
//
//  Created by rakhmatillo topiboldiev on 06/04/23.
//

import Foundation
import SocketIO
import SwiftyJSON

public protocol MySocketDelegate {
}

public class MySocket {

    var socketDelegate: MySocketDelegate?
//
    public static let `default` = MySocket()
    
    private let manager: SocketManager = SocketManager(socketURL: URL(string: "https://kids.datagaze-lab.uz/")!, config: [.connectParams(["token" : Cache.getUserToken()]), .compress])
//
     private init() {
        manager.connect()
        manager.defaultSocket.on(clientEvent: .connect) { (a, b) in
            print("CONNECTED to SOCKET")
        }


    }

    public func openConnection() {
        manager.defaultSocket.connect()
    }
    public func sendSOS(child_id: Int){
        let d = ["childID" : child_id]
        manager.defaultSocket.emit("sos", d) {
            print(child_id)
            print("Jo'nadi SOS")
        }
    }
    
    ///childID -> child ID, command -> which service you want to get, params -> services in how long day
    ///If I want to get microphone recordings of 5 days, then I will give the number of days to 5.
    public func sendCommand(childID: Int, command: String, params: String){
        let d : [String : Any] = [
             "childID" : "\(childID)",
             "command": command,
             "params" : params
            ]
        manager.defaultSocket.emit("command", d) {
            
            print("Jo'nadi")
        }
    }
    
    public func listenSOS(){
        manager.defaultSocket.on("sos") { data, emitter in
            let d = data.first as! NSDictionary
            print(d)
            print("🥰")
        }
    }
//
//    public func listenSocket(for id: String) {
//
//        manager.defaultSocket.on(id) { (data, emiter) in
//            let st = data.first as! NSDictionary
//            let jsonData = JSON(st)
//            print("SOCKET JSONDATA: ", jsonData)
//            switch jsonData["type"].stringValue{
//            case "ordered":
//                print("ordered🥰🥰")
//                self.socketDelegate?.didOrdered()
//            case "waitingDriver":
//                self.socketDelegate?.didWaitingDriver()
//            case "waitingRider":
//                self.socketDelegate?.didWaitingRider()
//            case "in_progress":
//                print("in progreesss🥰🥰")
//                self.socketDelegate?.didInProgress()
//            case "finished":
//                print("finished🥰🥰")
//                self.socketDelegate?.didFinished()
//            case "canceled":
//                print("cancelled🥰🥰")
//                self.socketDelegate?.didCancelled()
//            case "i_am_coming":
//                print("i am coming🥰🥰")
//                self.socketDelegate?.didIAmComing()
//            case "pre_cancelled":
//                print("pre_cancelled 🥰🥰")
//                self.socketDelegate?.didPreCancelled()
//
//            case "driver_location_change":
//                self.socketDelegate?.didDriverLocationChanged(location_name: jsonData["data"]["location"]["location_name"].stringValue, latitude: jsonData["data"]["location"]["latitude"].doubleValue, longitude: jsonData["data"]["location"]["longitude"].doubleValue, bearing: jsonData["data"]["bearing"].doubleValue, speed: jsonData["data"]["speed"].doubleValue)
//
//            case "ride_cost_change":
//                self.socketDelegate?.didRideCostChange(total_cost: jsonData["data"]["total_cost"].intValue)
//                print("ride cost change 🥰🥰")
//            default:
//                break
//            }
//
//
//        }
//
//
//    }
//
//
    public func disconnect() {
        manager.defaultSocket.disconnect()
    }
//
//
    
}
