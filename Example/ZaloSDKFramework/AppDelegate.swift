//
//  AppDelegate.swift
//  ZaloSDKFramework
//
//  Created by acct<blob>=<NULL> on 09/26/2017.
//  Copyright (c) 2017 acct<blob>=<NULL>. All rights reserved.
//

import UIKit
import ZaloSDKFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let zaloAppId = "1829577289837795818"
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        /// 0a. Init zalo sdk
        ZaloSDKFramework.sharedInstance.initialize(appId: zaloAppId)
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        /// 0b. Receive callback from zalo
        return ZaloSDKFramework.sharedInstance.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}

