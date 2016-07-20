//
//  ViewController.swift
//  FYGoogleSignIn
//
//  Created by Farhan Yousuf on 19/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /////////////////////////////////////////////////////////////////////////////
    //
    // MARK: - Variables
    //
    /////////////////////////////////////////////////////////////////////////////
    
    var delegate: FYAuthenticationProtocol?
    
    @IBOutlet weak var buttonGIDSignIn: GIDSignInButton!
    
    
    /////////////////////////////////////////////////////////////////////////////
    //
    // MARK: - View Life Cycles
    //
    /////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        buttonGIDSignIn.colorScheme = .Light
        buttonGIDSignIn.style = .Wide
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    
    /////////////////////////////////////////////////////////////////////////////
    //
    // MARK: - Actions
    //
    /////////////////////////////////////////////////////////////////////////////
    
    @IBAction func buttonActionSignInWithGoogle(sender: AnyObject) {
        
        GIDSignIn.sharedInstance().signIn()
    }
    
}

extension ViewController: GIDSignInDelegate {
    
    /////////////////////////////////////////////////////////////////////////////
    //
    // MARK: - GIDSignInDelegate
    //
    /////////////////////////////////////////////////////////////////////////////
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let name = user.profile.name
            let email = user.profile.email
            print("\(userId)")
            print("\(idToken)")
            print("\(name)")
            print("\(email)")
            
            delegate?.viewController(self, didSuccessfullyLoginUser: name)
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        delegate?.viewController(self, didFailToAuthenticateWithError: error)
    }
    
}

extension ViewController: GIDSignInUIDelegate {
 
    /////////////////////////////////////////////////////////////////////////////
    //
    // MARK: - GIDSignInUIDelegate
    //
    /////////////////////////////////////////////////////////////////////////////
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        
    }
    
    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}