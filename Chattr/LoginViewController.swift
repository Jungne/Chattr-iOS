//
//  LoginViewController.swift
//  Chattr
//
//  Created by Jungne Losang on 13/09/2019.
//  Copyright © 2019 Jungne Losang. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController {
    let authUI = FUIAuth.defaultAuthUI() //FirebaseUI
    var handle : AuthStateDidChangeListenerHandle? //Handle for login listener.

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Sets providers for FirebaseUI.
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth(),
        ]
        authUI!.providers = providers
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Segues to chat rooms screen if user is logged in.
        self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "loggedInSegue", sender: self)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(self.handle!)
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        //Opens the login screen on button press.
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true, completion: nil)
    }
}
