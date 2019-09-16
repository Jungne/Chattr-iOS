//
//  ChatViewController.swift
//  Chattr
//
//  Created by Jungne Losang on 15/09/2019.
//  Copyright © 2019 Jungne Losang. All rights reserved.
//

import UIKit
import MessageKit

class ChatViewController: MessagesViewController {
    
    let messages: [MessageType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController : MessagesDataSource {
    func currentSender() -> SenderType {
        return UserData.messageSender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
}

extension ChatViewController : MessagesLayoutDelegate, MessagesDisplayDelegate {}
