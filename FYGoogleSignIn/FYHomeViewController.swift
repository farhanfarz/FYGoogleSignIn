//
//  FYHomeViewController.swift
//  FYGoogleSignIn
//
//  Created by Farhan Yousuf on 19/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

import UIKit

class FYHomeViewController: UIViewController {

    /////////////////////////////////////////////////////////////////////////////
    //
    // MARK: - Variables
    //
    /////////////////////////////////////////////////////////////////////////////
    
    var delegate: FYAuthenticationProtocol?
    
    
    /////////////////////////////////////////////////////////////////////////////
    //
    // MARK: - View Life Cycles
    //
    /////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FYHomeViewController {
    
    /////////////////////////////////////////////////////////////////////////////
    //
    // MARK: - Actions
    //
    /////////////////////////////////////////////////////////////////////////////
    
    @IBAction func buttonActionLogoutFromGoogle(sender: AnyObject) {
        
        GIDSignIn.sharedInstance().signOut()
        
        delegate?.viewController(self, didLogoutUser: nil)
    }
    
}
