//
//  AppDelegate.swift
//  PlainTest
//
//  Created by Karim Omar on 10.06.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let appContext = AppContext()
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        navController.setViewControllers([ViewController()], animated: false)

        window?.rootViewController = navController
//        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }

    


}

