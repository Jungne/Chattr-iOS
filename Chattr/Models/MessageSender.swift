//
//  MessageSender.swift
//  Chattr
//
//  Created by Jungne Losang on 15/09/2019.
//  Copyright © 2019 Jungne Losang. All rights reserved.
//

import Foundation
import MessageKit

struct MessageSender: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
