//
//  Message.swift
//  Chattr
//
//  Created by Jungne Losang on 15/09/2019.
//  Copyright © 2019 Jungne Losang. All rights reserved.
//

import Foundation
import MessageKit

struct Message: MessageType {
    var messageId: String
    var sender: SenderType {
        return user
    }
    var sentDate: Date
    var kind: MessageKind
    var user: MessageSender
    
    private init(kind: MessageKind, user: MessageSender, messageId: String, date: Date) {
        self.kind = kind
        self.user = user
        self.messageId = messageId
        self.sentDate = date
    }
    
    init?(text: String, user: MessageSender, messageId: String, date: Date) {
        self.init(kind: .text(text), user: user, messageId: messageId, date: date)
    }
}

extension Message: Comparable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.messageId == rhs.messageId
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}
