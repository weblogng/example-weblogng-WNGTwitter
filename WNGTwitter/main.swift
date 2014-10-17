//
//  main.swift
//  WNGTwitter
//
//  Created by tstechly, Stephen Kuenzli on 10/16/14.
//  Copyright (c) 2014 WeblogNG. All rights reserved.
//

import Foundation
import UIKit

NSLog("starting WNGTwitter")

let  apiKey = "93c5a127-e2a4-42cc-9cc6-cf17fdac8a7f";
WNGLogger.initSharedLogger(apiKey)
WNGLogger.sharedLogger().recordStart("application-launch")
NSURLConnection.wng_setLogging(true)

UIApplicationMain(C_ARGC, C_ARGV, NSStringFromClass(UIApplication), NSStringFromClass(AppDelegate))

