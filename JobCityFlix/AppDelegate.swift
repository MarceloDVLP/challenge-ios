//
//  AppDelegate.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 27/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .brown
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}


