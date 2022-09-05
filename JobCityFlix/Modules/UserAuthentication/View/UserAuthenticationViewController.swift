import UIKit

final class UserAuthenticationViewController: UIViewController {
        
    var interactor: UserAuthenticationInteractor!

    private lazy var authenticationView: UserAuthenticationView = {
        let authenticationView = UserAuthenticationView()
        authenticationView.delegate = self
        return authenticationView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        constraintAuthenticationView()
    }
    
    private func constraintAuthenticationView() {
        view.constrainSubView(view: authenticationView, top: 0, bottom: 0, left: 0, right: 0)
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
        })
    }
    
    func showTvShow() {
        guard let window = view.window else { return }
        
        window.rootViewController = TabViewController()
        window.makeKeyAndVisible()
    }
    
    public func showLogin() {
        authenticationView.showLogin()
    }
    
    public func showRegister() {
        authenticationView.showRegister()
    }
}

extension UserAuthenticationViewController: UserAuthenticationViewDelegate {

    func didTapCancel() {
        interactor.didTapCancel()
    }
    
    func didTapConfirm(_ user: User) {
        interactor.didTapConfirm(user)
    }
    
    func didTapRegister() {
        interactor.didTapRegister()
    }
    
    func didTapSignIn(_ userName: String?, _ pin: String?) {
        interactor.didTapSignIn(userName, pin)
    }
    
    func didTapSignInFaceID() {
        interactor.didTapSignInFaceID()
    }
}


