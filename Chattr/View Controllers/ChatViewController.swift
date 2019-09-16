//
//  ChatViewController.swift
//  Chattr
//
//  Created by Jungne Losang on 15/09/2019.
//  Copyright © 2019 Jungne Losang. All rights reserved.
//

import UIKit
import Firebase
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {
    var roomId: String?
    var messages: [Message] = []
    let sender: MessageSender = UserData.messageSender
    var messageListener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        listenForMessages(roomId: self.roomId!)
    }
    
    func saveMessage(message: String) {
        DatabaseManager.db.saveMessage(roomId: roomId!, sender: sender, message: message)
    }
    
    //Attaches message listener.
    func listenForMessages(roomId: String) {
        messageListener = DatabaseManager.db.fsdb.collection("chatrooms").document(roomId).collection("messages")
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                snapshot.documentChanges.forEach() { diff in
                    if (diff.type == .added) {
                        self.handleDocumentChange(newMessage: diff)
                    }
                    
                }
        }
    }
    
    private func handleDocumentChange(newMessage: DocumentChange) {
        let document = newMessage.document
        let data = document.data()
        let text = data["message"]
        let sender = MessageSender(senderId: data["senderId"] as! String, displayName: data["senderName"] as! String)
        let messageId = document.documentID
        let timestamp = data["timestamp"] as! Timestamp
        let date = timestamp.dateValue()
        guard var message = Message(text: text as! String, user: sender, messageId: messageId, date: date as! Date) else {
            return
        }
        insertNewMessage(message: message)
    }
    
    func insertNewMessage(message: Message) {
        messages.append(message)
        messages.sort()
        
        messagesCollectionView.reloadData()
    }
}

extension ChatViewController : MessagesDataSource {
    func currentSender() -> SenderType {
        return sender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = inputBar.inputTextView.components[0] as! String
        saveMessage(message: message)
        messageInputBar.inputTextView.text = ""
        //messageInputBar.sendButton.startAnimating()
    }
}

extension ChatViewController: MessagesLayoutDelegate, MessagesDisplayDelegate {}
