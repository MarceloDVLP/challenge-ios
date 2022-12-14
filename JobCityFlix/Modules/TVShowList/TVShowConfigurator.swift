import UIKit

final class TVShowListConfigurator {
    
    static func make() -> UIViewController {
        let session = URLSession.shared
        let service = ServiceAPI(client: HTTPClient(session: session))
        let container = PersistentContainer.shared.persistentContainer
        let manager = FavoriteManager(persistentContainer: container)
        let presenter = TVShowPresenter()
        
        let interactor = TVShowInteractor(manager: manager, service: service, presenter: presenter)
        let viewController = TVShowListViewController(interactor: interactor)

        presenter.viewController = viewController
        viewController.interactor = interactor
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        return navigation
    }
}

protocol TVShowPresenterProtocol: AnyObject {
    func willStartFetch()
    func show(_ tvShows: [TVShowModel])
    func showError(_ error: Error)
}

protocol SearchShowPresenterProtocol: AnyObject {
    func willStartFetch()
    func show(_ tvShows: [TVShowModel])
    func show(_ persons: [Person])
    func show(_ error: Error)
}

protocol SearchShowViewControllerProtocol: AnyObject {
    func showLoadig()
    func show(_ tvShows: [TVShowModel])
    func show(_ persons: [Person])
    func showError(_ error: Error)
    func removeLoading()
}

protocol TVShowInteractorProtocol {
    func viewDidLoad()
    func didFinishPage()
    func didTapAddFavorite(_ show: TVShowModel)
}

protocol TVShowListViewControllerProtocol: AnyObject {
    func showLoadig()
    func showEpisodes(_ tvShows: [TVShowModel])
    func showError(_ error: Error)
    func removeLoading()
}
