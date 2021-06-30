//
//  AppDelegate.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 05/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

// MARK: - Init
// MARK: - View life cycle
// MARK: - Setup
// MARK: - Action
// MARK: - Data
// MARK: - IBOutlet
// MARK: - Proprities
// MARK: - Controller accessor
// MARK: - View life cycle
// MARK: - User Interface
// MARK: - Private methods
// MARK: - User Action


import UIKit
import Sentry

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var locationManager = LocationManager()
    
    var rootController: UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }
    
    private lazy var applicationCoordinator: Coordinator = ApplicationCoordinator(router: Router(rootController: self.rootController), coordinatorFactory: CoordinatorFactory())
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // create the main navigation controller to be used for our app
        initSentry()
        //SentrySDK.capture(message: "My first test message From ShuffleEat")
        locationManager.delegate = self
        
        if #available(iOS 13, *) {
            // do only pure app launch stuff, not interface stuff
        } else {
            
            if UserDefaults.standard.bool(forKey: Constants.UserDefaults.launchedBefore.rawValue) {
                
            } else {
                
                UserDefaults.standard.set(true, forKey: Constants.UserDefaults.launchedBefore.rawValue)
                UserDefaults.standard.set(true, forKey: Constants.UserDefaults.notificationActivated.rawValue)
            }
            
            self.applicationCoordinator.start(with: nil)
            return true
        }
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("User gave permissions for local notifications")
            }
        }
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
    
    func initSentry() {
        SentrySDK.start { options in
            options.dsn = "https://6db3c575f3994e80b715d5819789ebcc@o452904.ingest.sentry.io/5441021"
            options.debug = true // Enabled debug when first installing is always helpful
            options.enableAutoSessionTracking = true // Enable session tracking
        }
    }
}
