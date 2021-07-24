//
//  AppDelegate.swift
//  SaveState
//
//  Created by LanceMacBookPro on 7/24/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let loginVC = LoginController()
        let navVC = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = navVC
        
        return true
    }
}

