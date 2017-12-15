//
//  AppDelegate.swift
//  Rawandale
//
//  Created by Rushikesh Kulkarni on 18/09/17.
//  Copyright © 2017 simplicity. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import GoogleSignIn
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import UserNotifications
import AudioToolbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var token: String = ""
    var window: UIWindow?
    var storyBoard :UIStoryboard?
    var navigationController : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Register for Push Notification
        self.fnForRegisterRemoteNotification()
        
        //For IQKeyboardManager
        IQKeyboardManager.sharedManager().enable = true
        
        // Facebook
         FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        if navigationController == nil {
            navigationController = UINavigationController()
        }
        if storyBoard == nil {
            storyBoard = UIStoryboard(name:"Main", bundle:nil)
        }
        navigationController?.setNavigationBarHidden(true, animated: true)
        if let loginStates = (UserDefaults.standard.value(forKey: "isLoggedIn") as? String)  {
            if loginStates == "1" {
                let revealViewController = storyBoard?.instantiateViewController(withIdentifier: "RevealViewController") as! RevealViewController
                navigationController?.pushViewController(revealViewController , animated: true)
            }
            else {
                let loginViewController = storyBoard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                navigationController?.pushViewController(loginViewController , animated: true)
            }
            
        }
        else {
            let loginViewController = storyBoard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(loginViewController , animated: true)
        }
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
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
        // Saves changes in the application's managed object context before the application terminates.
//        self.saveContext()
    }

    // MARK: - Core Data stack
    /*lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Rawandale")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }*/
    
    //MARK:- CallBack Methods
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let checkFB = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        let checkGoogle = GIDSignIn.sharedInstance().handle(url as URL!, sourceApplication: sourceApplication,annotation: annotation)
        return checkGoogle || checkFB
    }
    //MARK:- Notifications
    func fnForRegisterRemoteNotification()  {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            UIApplication.shared.registerForRemoteNotifications()
        }
        else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    //MARK:-Remote Notification Delegate // <= iOS 9.x
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        UIApplication.shared.registerForRemoteNotifications()
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Got token data! \(deviceToken)")
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
        }
        print("Device Token Id \(token)")
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    //MARK:- UNUserNotificationCenter Delegate // >= iOS 10
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        print("User Info = %@",notification.request.content.userInfo)
        completionHandler([.badge, .alert, .sound])
        
    }
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, didReceiveNotificationResponse response: UNNotificationResponse, withCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        print("User Info = %@",response.notification.request.content.userInfo);
        let application:UIApplication = UIApplication.shared
        if application.applicationState == UIApplicationState.active {
            print("Active")
            AudioServicesPlaySystemSound(1002)
        }
        else if application.applicationState == UIApplicationState.background {
            print("Background")
            self .callApplicationInactiveForPush(payload: response.notification.request.content.userInfo as NSDictionary)
        }
        else if application.applicationState == UIApplicationState.inactive {
            print("InActive")
            self .callApplicationInactiveForPush(payload: response.notification.request.content.userInfo as NSDictionary)
        }
        completionHandler(.newData)
    }
    func callApplicationInactiveForPush(payload:NSDictionary){
        print(payload)
        
    }
    
    
    

}

