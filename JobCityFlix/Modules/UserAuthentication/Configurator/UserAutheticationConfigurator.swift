import LocalAuthentication

final class UserAutheticationConfigurator {
    
    static func make() -> UserAuthenticationViewController {
        let interactor = UserAuthenticationInteractor()
        let presenter = UserAuthenticationPresenter()
        let viewController = UserAuthenticationViewController(interactor: interactor)
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        
        return viewController
    }
}
