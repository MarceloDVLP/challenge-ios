import Foundation

protocol UserAuthenticationInteractorProtocol {
    func didTapConfirm(_ user: User)
    func didTapCancel()
    func didTapSignIn(_ userName: String?, _ pin: String?)
    func didTapSignInFaceID()
    func didTapRegister()
}

final class UserAuthenticationInteractor: UserAuthenticationInteractorProtocol {
    
    private let auth = LocalAuthentication()
    var presenter: UserAuthenticationPresenter!
    private let userNameKey = "username"
    private let pinKey = "pin"
    
    func didTapConfirm(_ user: User) {
        didTapSignIn(user.name, user.pin)
    }
    
    func didTapCancel() {
        presenter.showLogin()
    }
    
    func didTapRegister() {
        presenter.showRegister()
    }
    
    func didTapSignIn(_ userName: String?, _ pin: String?) {
        if isValid(userName, pin) {
            saveCredentials(userName, pin)
            presenter.showLoginSuccess()
        } else {
            presenter.showLoginFailure(LoginError.invalidUserOrPassword)
        }
    }
    
    func didTapSignInFaceID() {
        auth.tryLocalAuthentication({ [weak self ] result in
            switch result {
            case .success(let isAuthenticated):
                isAuthenticated ? self?.presenter.showLoginSuccess() :
                                  self?.presenter.showLoginFailure(.invalidUserOrPassword)
            case .failure(_):
                self?.presenter.showLoginFailure(.invalidUserOrPassword)
            }
        })
    }
    
    private func isLocalAuthenticationEnabled() -> Bool {
        return auth.isLocalAuthenticationPermitted() &&
        (auth.isFaceIDEnabled() || auth.isTouchIDEnabled())
    }
    
    private func hasLoggedUser() -> Bool {
        return retriveCredentials() != (nil, nil)
    }
    
    private func saveCredentials(_ userName: String?, _ pin: String?) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(userName, forKey: userNameKey)
        userDefaults.set(pin, forKey: pinKey)
    }
    
    private func isValid(_ userName: String?, _ pin: String?) -> Bool {
        if (userName == nil || userName == "") || (pin == nil || pin == "") {
            return false
        }
        
        if hasLoggedUser() {
            let (loggedName, loggedPin) = retriveCredentials()
            return userName == loggedName && pin == loggedPin
        } else {
            return true
        }
    }
    
    private func retriveCredentials() -> (String?, String?) {
        let userDefaults = UserDefaults.standard
        let userName = userDefaults.string(forKey: userNameKey)
        let pin = userDefaults.string(forKey: pinKey)
        return (userName, pin)
    }
}

enum LoginError {
    
    case invalidUserOrPassword
    
    var title: String {
        return "Invalid User Or Password!"
    }
    var message: String {
        return "Please, check your username or password and try again :)"
    }
}
