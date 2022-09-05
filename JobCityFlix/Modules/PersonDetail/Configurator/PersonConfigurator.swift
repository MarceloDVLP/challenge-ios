import UIKit

final class PersonDetailConfigurator {
    
    static func make(_ person: Person) -> UIViewController {
        let session = URLSession.shared
        let service = ServiceAPI(client: HTTPClient(session: session))

        let presenter = PersonDetailPresenter()

        let interactor = PersonDetailInteractor(service: service, presenter: presenter, person: person)
        let viewController = PersonDetailViewController(interactor: interactor)

        presenter.viewController = viewController
        
        
        return viewController
    }
}

protocol PersonDetailPresenterProtocol: AnyObject {
    func willStartFetch()
    func show(_ person: Person)
    func show(_ shows: [TVShowModel])
    func showError(_ error: Error)
}

protocol PersonDetailInteractorProtocol {
    func viewDidLoad()
}

protocol PersonDetailViewControllerProtocol: AnyObject {
    func showLoadig()
    func show(_ episodes: [TVShowModel])
    func show(_ person: Person)
    func showError(_ error: Error)
    func removeLoading()
}
