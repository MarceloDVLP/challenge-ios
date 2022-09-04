import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            
            let navigationBarAppearance = UINavigationBarAppearance()
              navigationBarAppearance.configureWithTransparentBackground()
              UINavigationBar.appearance().standardAppearance = navigationBarAppearance
              UINavigationBar.appearance().compactAppearance = navigationBarAppearance
              UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        

            self.window = UIWindow(windowScene: windowScene)
            let mainNavigationController = TabViewController()
            self.window?.rootViewController = mainNavigationController
            self.window?.makeKeyAndVisible()
        }
    }
}
