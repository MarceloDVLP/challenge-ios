import UIKit

final class TVShowDetailConfigurator {
    
    static func make() -> UIViewController {
        let session = URLSession.shared
        let service = ServiceAPI(client: HTTPClient(session: session))

        let presenter = TVShowDetailPresenter()

        let interactor = TVShowDetailInteractor(service: service, presenter: presenter)
        let viewController = TVShowDetailViewController(interactor: interactor)

        presenter.viewController = viewController
        viewController.interactor = interactor
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        return navigation
    }
}

protocol TVShowDetailPresenterProtocol: AnyObject {
    func willStartFetch()
    func showEpisodes(_ tvShows: [TVShowDetailCodable])
    func showError(_ error: Error)
    
}

protocol TVShowDetailInteractorProtocol {
    func viewDidLoad()
}

protocol TVShowDetailViewControllerProtocol: AnyObject {
    func showLoadig()
    func showEpisodes(_ tvShows: [TVShowDetailCodable])
    func showError(_ error: Error)
    func removeLoading()
}
