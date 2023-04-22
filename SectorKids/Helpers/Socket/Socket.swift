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
    ///command types: 0xMI, 0xAU, 0xLO, 0xCO
    #warning("CHILD ID NI O'ZGARTIRISH KERAK")
    public func sendCommand(childID: Int, command: String, params: String){
        let d : [String : Any] = [
             "childID" : "\(16)",
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
        }
    }
    public func disconnect() {
        manager.defaultSocket.disconnect()
    }
//
//
    
}
