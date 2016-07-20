//
//  AppDelegate.swift
//  FYGoogleSignIn
//
//  Created by Farhan Yousuf on 19/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        if window == nil {
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window?.makeKeyAndVisible()
            
        }
        window?.tintColor = UIColor.blackColor()
        window?.clipsToBounds = true
        
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()) {
            GIDSignIn.sharedInstance().signInSilently()
            
            customizeForHome()
            
            return true
        }

        customizeForLogin()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
    }

}

extension AppDelegate {
    
    /////////////////////////////////////////////////////////////////////////////
    //
    // MARK: - Methods
    //
    /////////////////////////////////////////////////////////////////////////////
    
    func customizeForLogin() {
        
        if let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController {
            loginViewController.delegate = self
            window?.rootViewController = loginViewController
        }
    }
    
    func customizeForHome() {
        
        if let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeVCStoryboardIdentifier") as? FYHomeViewController {
            homeViewController.delegate = self
            window?.rootViewController = homeViewController
        }
    }
}

extension AppDelegate: FYAuthenticationProtocol {
    
    /////////////////////////////////////////////////////////////////////////////
    //
    // MARK: - FYAuthenticationProtocol
    //
    /////////////////////////////////////////////////////////////////////////////
    
    func viewController(viewController: UIViewController, didSuccessfullyLoginUser user: AnyObject) {
        customizeForHome()
    }
    
    func viewController(viewController: UIViewController, didFailToAuthenticateWithError error: NSError?) {
        
    }
    
    func viewController(viewController: UIViewController, didLogoutUser user: AnyObject?) {
        customizeForLogin()
    }
}
