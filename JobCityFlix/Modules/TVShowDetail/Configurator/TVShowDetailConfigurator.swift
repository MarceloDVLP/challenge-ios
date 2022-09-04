import UIKit

final class TVShowDetailConfigurator {
    
    static func make(_ tvShow: TVShowCodable) -> UIViewController {
        let session = URLSession.shared
        let service = ServiceAPI(client: HTTPClient(session: session))
        let manager = FavoriteManager.shared

        let presenter = TVShowDetailPresenter()
        let interactor = TVShowDetailInteractor(service: service, manager: manager, presenter: presenter, tvShow: tvShow)
        let viewController = TVShowDetailViewController(interactor: interactor)

        presenter.viewController = viewController
        
        
        return viewController
    }
}

protocol TVShowDetailPresenterProtocol: AnyObject {
    func willStartFetch()
    func show(_ tvShow: TVShowCodable, _ isFavorited: Bool)
    func show(_ episodes: [Episode])
    func showError(_ error: Error)
    
}

protocol TVShowDetailInteractorProtocol {
    func viewDidLoad()
    func didTapFavorite()
}

protocol TVShowDetailViewControllerProtocol: AnyObject {
    func showLoadig()
    func show(_ episodes: [[Episode]], _ seasons: [String])
    func show(_ tvShow: TVShowCodable, _ isFavorited: Bool)
    func showError(_ error: Error)
    func removeLoading()
}

public enum TVShowDetailMenu: Int {
    case episodes
    case about
    case empty
    
    var sections: [TVShowDetailSection] {

        switch self {
        case .episodes: return [.detail, .menu, .season, .episodes]
        case .about: return [.detail, .menu, .about]
        case .empty: return []
        }
    }
}

public enum SearchMenu: Int {
    case tvShows
    case actors
    case empty
    
    var sections: [SearchSection] {

        switch self {
        case .tvShows: return [.menu, .result]
        case .actors: return []
        case .empty: return []
        }
    }
}
