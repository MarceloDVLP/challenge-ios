import Foundation

final class UserAuthenticationInteractor {

    private let auth = LocalAuthentication()
    var presenter: UserAuthenticationPresenter!
    private let userNameKey = "username"
    private let pinKey = "pin"

    func viewDidLoad() {
        if isLocalAuthenticationEnabled() && hasLoggedUser() {
            
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
    }
    
    func isLocalAuthenticationEnabled() -> Bool {
        return auth.isLocalAuthenticationPermitted() &&
        (auth.isFaceIDEnabled() || auth.isTouchIDEnabled())
    }
    
    func hasLoggedUser() -> Bool {
        return retriveCredentials() != (nil, nil)
    }
    
    func didTapSignIn(_ userName: String?, pin: String?) {
        if isValid(userName, pin) {
            saveCredentials(userName, pin)
            auth.tryLocalAuthentication({ _ in })
            presenter.showLoginSuccess()
        } else {
            presenter.showLoginFailure(LoginError.invalidUserOrPassword)
        }
    }
    
    func saveCredentials(_ userName: String?, _ pin: String?) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(userName, forKey: userNameKey)
        userDefaults.set(pin, forKey: pinKey)
    }
    
    func isValid(_ userName: String?, _ pin: String?) -> Bool {
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
    
    func retriveCredentials() -> (String?, String?) {
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
