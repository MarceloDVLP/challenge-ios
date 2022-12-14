import Foundation

final class SearchShowPresenter: SearchShowPresenterProtocol {

    weak var viewController: SearchShowViewControllerProtocol?
    
    func willStartFetch() {
        viewController?.showLoadig()
    }

    func show(_ tvShows: [TVShowModel]) {
        viewController?.removeLoading()
        viewController?.show(tvShows)
    }
    
    func show(_ persons: [Person]) {
        viewController?.removeLoading()
        viewController?.show(persons)
    }

    func show(_ error: Error) {
        viewController?.showError(error)
    }
}
