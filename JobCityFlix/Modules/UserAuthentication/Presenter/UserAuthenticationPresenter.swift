import Foundation

final class UserAuthenticationPresenter {
    
    var viewController: UserAuthenticationViewController!
    
    func showLoginFailure(_ error: LoginError) {
        Thread.executeOnMain { [weak self] in
            self?.viewController.show(error)
        }
    }
    
    func showLoginSuccess() {
        Thread.executeOnMain { [weak self] in
            self?.viewController.showTvShow()
        }
    }
    
    func showLogin() {
        viewController.showLogin()
    }
    
    func showRegister() {
        viewController.showRegister()
    }
}
