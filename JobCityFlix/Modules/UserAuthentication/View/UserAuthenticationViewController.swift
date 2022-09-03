import UIKit

final class UserAuthenticationViewController: UIViewController {
        
    var interactor: UserAuthenticationInteractor!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authenticationView = UserAuthenticationView()
        view.constrainSubView(view: authenticationView, top: 0, bottom: 0, left: 0, right: 0)
                
        interactor.viewDidLoad()
    }
    
    func show(_ error: LoginError) {
        let alertController = UIAlertController()
        alertController.title = error.title
        alertController.message = error.message
        alertController.isSpringLoaded = true
        let action = UIAlertAction(title: "Try Again Now", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            
            self.dismiss(animated: true)
//            self.userTextField.becomeFirstResponder()
        })
    }
    
    func showTvShow() {
        guard let window = view.window else { return }
        
        window.rootViewController = TabViewController()
        window.makeKeyAndVisible()
    }
}


