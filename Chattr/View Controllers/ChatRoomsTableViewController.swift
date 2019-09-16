//
//  ChatRoomsTableViewController.swift
//  Chattr
//
//  Created by Jungne Losang on 15/09/2019.
//  Copyright © 2019 Jungne Losang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI


class ChatRoomsTableViewController: UITableViewController {
    //Variable declarations
    var db: Firestore!
    var chatRoomsArray = [ChatRoom]()
    var roomId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Firestore reference.
        db = DatabaseManager.db.fsdb
        
        //Retrieves the chat rooms from database and saves them to an array for showing in tableview.
        db.collection("chatrooms").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //TODO Add last message and timestamp.
                    let roomId = document.documentID
                    let roomName = document.data()["roomName"] as! String
                    let lastMessage = "Last message"
                    let lastMessageTime = NSDate().timeIntervalSince1970
                    let newChatRoom = ChatRoom(roomId: roomId, roomName: roomName, lastMessage: lastMessage, lastMessageTime: lastMessageTime)
                    self.chatRoomsArray.append(newChatRoom)
                }
            }
            //Reloads tableview to show data.
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomCell", for: indexPath)
        
        //Uses the chat room data to create the cell.
        let chatRoom = chatRoomsArray[indexPath.row]
        cell.textLabel?.text = chatRoom.roomName
        cell.detailTextLabel?.text = chatRoom.lastMessage

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Opens the chat room and passes the room id along.
        let roomId = chatRoomsArray[indexPath.row].roomId
        let vc = ChatViewController()
        vc.roomId = roomId
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func onClick(_ sender: UIBarButtonItem) {
        do {
            try FUIAuth.defaultAuthUI()?.signOut()
            //Segues to login screen
            self.performSegue(withIdentifier: "loggedOutSegue", sender: self)
        } catch is NSError {
            print("Sign out failed")
        }
    }
    
}
