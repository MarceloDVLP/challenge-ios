import Foundation

final class PersonDetailPresenter: PersonDetailPresenterProtocol {

    weak var viewController: PersonDetailViewControllerProtocol?
    
    func willStartFetch() {
        viewController?.showLoadig()
    }

    func show(_ person: Person) {
        Thread.executeOnMain { [weak self] in
            self?.viewController?.removeLoading()
            self?.viewController?.show(person)
        }
    }

    func showError(_ error: Error) {
        viewController?.showError(error)
    }
    
    func show(_ shows: [TVShowCodable]) {
        Thread.executeOnMain { [weak self] in
            self?.viewController?.removeLoading()
            self?.viewController?.show(shows)
        }
    }
}
