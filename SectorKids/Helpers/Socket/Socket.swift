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
    func didOrdered()
    func didWaitingDriver()
    func didWaitingRider()
    func didInProgress()
    func didFinished()
    func didCancelled()
    func didIAmComing()
    func didPreCancelled()
    func didDriverLocationChanged(location_name: String, latitude: Double, longitude: Double, bearing: Double, speed: Double)
    func didRideCostChange(total_cost: Int)
    
}

public class MySocket {
    

//    var socketDelegate: MySocketDelegate?
//
//    public static let `default` = MySocket()
//
//    private let manager: SocketManager = SocketManager(socketURL: URL(string: API.baseURL)!, config: [ .path("/api/socket.io/"), .extraHeaders(["Authorization" : "Bearer \(Cache.getUser()?.token ?? "")"]), .forcePolling(true), .compress])
//
//     private init() {
//        manager.defaultSocket.on(clientEvent: .connect) { (a, b) in
//
//        }
//
//
//    }
//
//
//    public func openConnection() {
//        manager.defaultSocket.connect()
//    }
//
//
//
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
//    public func disconnect() {
//        manager.defaultSocket.disconnect()
//    }
//
//
    
}
