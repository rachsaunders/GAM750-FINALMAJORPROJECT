//
//  AppDelegate.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 10/02/2021.
//
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//
//
//I have made this app using several Cocoapod Libraries. If you wish to test this application on your device you will need to install the following Cocoapods - Firebase, Gallery, NVActivityIndicatorView/AppExtension, ProgressHUD, SKPhotoBrowser, Shuffle-iOS, MessageKit and InputBarAccessoryView otherwise errors will throw.

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Configures Firebase
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        requestPushNotificationPermission()
        
        setupUIConfigurations()
        
        application.registerForRemoteNotifications()
        application.applicationIconBadgeNumber = 0
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    //MARK:- UICONFIGURATION
    
    private func setupUIConfigurations() {
        
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor().primary()
        UITabBar.appearance().unselectedItemTintColor = UIColor().tabBarUnselected()
        UITabBar.appearance().tintColor = .white
        
        
        UINavigationBar.appearance().barTintColor = UIColor().primary()
        UINavigationBar.appearance().backgroundColor = UIColor().primary()
        UIBarButtonItem.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        
    }
    
    //MARK:- PUSH NOTIFICATIONS
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("unable to register for remote notifications", error.localizedDescription)
    }
    
    private func requestPushNotificationPermission() {
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions  = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        
    }

    private func updateUserPushId(newPushId: String) {
        
        if let user = FUser.currentUser() {
            user.pushId = newPushId
            user.saveUserLocally()
            user.updateCurrentUserInFireStore(withValues: [kPUSHID : newPushId]) { (error) in
                print("update current user in firestore test")
            }
        }
    }
    
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
}

extension AppDelegate : MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("user push id is ", fcmToken)
        updateUserPushId(newPushId: fcmToken)
    }
    
}

