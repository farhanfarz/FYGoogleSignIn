//
//  FYAuthenticationProtocol.swift
//  FYGoogleSignIn
//
//  Created by Farhan Yousuf on 19/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

import UIKit

@objc protocol FYAuthenticationProtocol: NSObjectProtocol {
    
    func viewController(viewController:UIViewController, didSuccessfullyLoginUser user:AnyObject)
    func viewController(viewController:UIViewController, didFailToAuthenticateWithError error:NSError?)
    func viewController(viewController:UIViewController, didLogoutUser user:AnyObject?)
}