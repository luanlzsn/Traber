//
//  AppDelegate.swift
//  Traber
//
//  Created by luan on 2017/4/20.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.init(rgb: 0x15181a)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
        LanguageManager.setupCurrentLanguage()
        initializationShareSDK()
        
        STPPaymentConfiguration.shared().publishableKey = "pk_test_3xSd4exZJAZujNR6fOG17QSF"
//        STPPaymentConfiguration.shared().publishableKey = "pk_live_2r1RbUmP0XvZeVh4vdC1aviZ"//正式环境
        
        return true
    }
    
    func initializationShareSDK() {
        ShareSDK.registerActivePlatforms([SSDKPlatformType.typeFacebook.rawValue], onImport: { (platform : SSDKPlatformType) in
            switch platform {
                case SSDKPlatformType.typeFacebook:
                    ShareSDKConnector.connectFacebookMessenger(FacebookConnector.classForCoder())
                default:
                    break
            }
        }) { (platform : SSDKPlatformType , appInfo : NSMutableDictionary?) in
            switch platform {
                case SSDKPlatformType.typeFacebook:
                    appInfo?.ssdkSetupFacebook(byApiKey: "212344722504668", appSecret: "7f64dc9c433c1ec80cab39658635c9b7", displayName: "traffic ticket",authType: SSDKAuthTypeBoth)
                default:
                    break
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

