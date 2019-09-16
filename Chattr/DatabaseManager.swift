//
//  DatabaseManager.swift
//  Chattr
//
//  Created by Jungne Losang on 16/09/2019.
//  Copyright © 2019 Jungne Losang. All rights reserved.
//

import Foundation
import Firebase
import MessageKit

class DatabaseManager {
    
    //Singleton instance.
    static let db = DatabaseManager()
    
    //Firestore instance.
    let fsdb = Firestore.firestore()
    
    //Returns a list of all chat rooms.
    func getChatRooms() -> [ChatRoom] {
        let chatRooms = [ChatRoom]()
        
        //TODO Retrieve chat rooms.
        
        return chatRooms
    }
    
    func saveMessage(roomId: String, sender: MessageSender, message: String) {
        let ref = fsdb.collection("chatrooms").document(roomId).collection("messages")
        ref.addDocument(data: [
            "senderId": sender.senderId,
            "senderName": sender.displayName,
            "message": message,
            "timestamp": Timestamp(date: Date())
        ])
    }
}
