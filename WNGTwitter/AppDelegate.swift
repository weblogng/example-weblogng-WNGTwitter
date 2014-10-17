//
//  AppDelegate.swift
//  WNGTwitter
//
//  Created by tstechly on 10/11/14.
//  Copyright (c) 2014 WeblogNG. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        
        /** NEED THIS DATA BEFORE I SHOW UI TO USER **/
        self.timeConsumingOperation()

        WNGLogger.sharedLogger().recordFinishAndSendMetric("application-launch")

        NSLog("AppDelegate:application:didFinishLaunchingWithOptions")

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



    /*
    DEMO METHODS

    */
    func timeConsumingOperation() {
            
         let baseURL = NSURL(string: "https://www.seoclerk.com/pics/219594-1lPi4C1400002116.png")
         let data = NSData(contentsOfURL: baseURL)
         var bgImage:UIImage = UIImage(data:data)

    }


}

