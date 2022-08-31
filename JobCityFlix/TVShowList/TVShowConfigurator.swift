import UIKit

final class TVShowListConfigurator {
    
    static func make() -> UIViewController {
        let session = URLSession.shared
        let service = ServiceAPI(client: HTTPClient(session: session))

        let presenter = TVShowPresenter()

        let interactor = TVShowInteractor(service: service, presenter: presenter)
        let viewController = TVShowListViewController(interactor: interactor)

        presenter.viewController = viewController
        viewController.interactor = interactor
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        return navigation
    }
}

protocol TVShowPresenterProtocol: AnyObject {
    func willStartFetch()
    func showEpisodes(_ tvShows: [TVShowCodable])
    func showError(_ error: Error)
    
}

protocol TVShowInteractorProtocol {
    func viewDidLoad()
    func didFinishPage() 
}

protocol TVShowListViewControllerProtocol: AnyObject {
    func showLoadig()
    func showEpisodes(_ tvShows: [TVShowCodable])
    func showError(_ error: Error)
    func removeLoading()
}
