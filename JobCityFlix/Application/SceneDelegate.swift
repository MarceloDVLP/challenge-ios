//
//  SceneDelegate.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 28/08/22.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            
            self.window = UIWindow(windowScene: windowScene)
            let mainNavigationController = UINavigationController(rootViewController: ViewController())
            self.window?.rootViewController = mainNavigationController
            self.window?.makeKeyAndVisible()
        }
    }
}
