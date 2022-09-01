import Foundation

final class SearchShowPresenter: SearchShowPresenterProtocol {

    weak var viewController: SearchShowViewControllerProtocol?
    
    func willStartFetch() {
        viewController?.showLoadig()
    }
    func show(_ tvShows: [TVShowCodable]) {
        viewController?.removeLoading()
        viewController?.show(tvShows)
    }
    func show(_ error: Error) {
        viewController?.showError(error)
    }
}
