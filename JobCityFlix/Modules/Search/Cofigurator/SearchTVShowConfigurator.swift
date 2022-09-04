import UIKit

final class SearchTVShowConfigurator {
    
    static func make() -> UIViewController {
        let session = URLSession.shared
        let service = ServiceAPI(client: HTTPClient(session: session))

        let presenter = SearchShowPresenter()

        let interactor = SearchShowInteractor(service: service, presenter: presenter)
        let viewController = SearchShowViewController(interactor: interactor)

        presenter.viewController = viewController
        viewController.interactor = interactor
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        return navigation
    }
}

enum SearchSection: Int, CaseIterable {
    case menu = 0
    case result = 1
}
