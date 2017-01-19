//
//  AppDelegate.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 5..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
//import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //1.Google Login
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")

        //2. get sign satuas
        self.window = UIWindow(frame: UIScreen.main.bounds)
    
        if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            //print("===================================== AppDelegete logining =====================================")
            GIDSignIn.sharedInstance().signInSilently();

            //로그인 상태면...Main 스토리보드로
            let firstStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = firstStoryboard.instantiateViewController(withIdentifier: "TabBarView")
            self.window?.rootViewController = viewController
        }else{
            //print("===================================== AppDeleget logg out =====================================")
            
            let userDefault = UserStaticInfo();
            userDefault.deleteDefaults()
            
            //로그아웃 상태면...First 스토리보드로
            let firstStoryboard = UIStoryboard(name: "First", bundle: nil)
            let viewController = firstStoryboard.instantiateViewController(withIdentifier: "First")
            self.window?.rootViewController = viewController
        }

        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    // [END openurl]
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    // [START signin_handler]
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            
            
            /*
             // [START_EXCLUDE silent]
             NotificationCenter.default.post(
             name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
             // [END_EXCLUDE]
             */
        } else {
            print("델리케이트 입니다")
            print("유저 이메일은 \(user.profile.email)")
            
            // Perform any operations on signed in user here.
            /*
             let userId = user.userID                  // For client-side use only!
             let idToken = user.authentication.idToken // Safe to send to the server
             let fullName = user.profile.name
             let givenName = user.profile.givenName
             let familyName = user.profile.familyName
             let email = user.profile.email
             // [START_EXCLUDE]
             NotificationCenter.default.post(
             name: Notification.Name(rawValue: "ToggleAuthUINotification"),
             object: nil,
             userInfo: ["statusText": "Signed in user:\n\(fullName)"])
             // [END_EXCLUDE]
             */
        }
    }
    // [END signin_handler]
    // [START disconnect_handler]
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
        /*
         NotificationCenter.default.post(
         name: Notification.Name(rawValue: "ToggleAuthUINotification"),
         object: nil,
         userInfo: ["statusText": "User has disconnected."])
         */
        // [END_EXCLUDE]
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

