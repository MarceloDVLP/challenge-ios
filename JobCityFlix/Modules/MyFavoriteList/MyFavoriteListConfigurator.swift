import UIKit

final class MyFavoriteListConfigurator {
    
    static func make() -> UIViewController {

        let presenter = MyFavoriteListPresenter()
        let manager = FavoriteManager.shared
        let interactor = MyFavoriteListInteractor(manager: manager)
        let viewController = MyFavoriteListViewController(interactor: interactor)
        interactor.delegate = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        return navigation
    }
}
