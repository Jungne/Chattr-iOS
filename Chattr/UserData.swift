//
//  UserData.swift
//  Chattr
//
//  Created by Jungne Losang on 16/09/2019.
//  Copyright © 2019 Jungne Losang. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserData {
    static var messageSender : MessageSender! {
        get {
            let currentUser = Auth.auth().currentUser
            return MessageSender(senderId: currentUser!.uid, displayName: currentUser!.displayName!)
        }
    }
}
