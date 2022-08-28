import Foundation

final class TVShowPresenter: TVShowPresenterProtocol {

    weak var viewController: TVShowListViewControllerProtocol?
    
    func willStartFetch() {
        viewController?.showLoadig()
    }
    func showEpisodes(_ tvShows: [TVShowCodable]) {
        viewController?.removeLoading()
        viewController?.showEpisodes(tvShows)
    }
    func showError(_ error: Error) {
        viewController?.showError(error)
    }
}
