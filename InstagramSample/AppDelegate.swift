//
//  AppDelegate.swift
//  InstagramSample
//
//  Created by Haehyeon Jeong on 09/04/2019.
//  Copyright © 2019 JHH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let clientID    = "2ea80bcdd38641deac2a0dc6043b6130"
    private let redirectUri = "http://localhost:3000?lg2ea80bcdd38641deac2a0dc6043b6130://authorize"
    
    private var loginViewController : LoginViewController?
    private var profileViewController  : UIViewController?
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupEntryController()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadRootViewController),
                                               name: NSNotification.Name.session.didChange,
                                               object: nil)

        self.reloadRootViewController()
        return true
    }
    

    private func setupEntryController(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.profileViewController  = UINavigationController(rootViewController: mainStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as UIViewController)
        self.loginViewController = LoginViewController(clidentId: self.clientID, redirectUri: self.redirectUri)
    }
    
    
    
    @objc private func reloadRootViewController(){
        let isLogin = UserInfo.token != "" ? true : false
        
        self.window?.rootViewController = isLogin ? self.profileViewController : self.loginViewController
        self.window?.makeKeyAndVisible()
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

