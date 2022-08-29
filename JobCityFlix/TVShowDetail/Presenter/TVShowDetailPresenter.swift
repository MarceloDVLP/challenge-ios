import Foundation

final class TVShowDetailPresenter: TVShowDetailPresenterProtocol {

    weak var viewController: TVShowDetailViewControllerProtocol?
    
    func willStartFetch() {
        viewController?.showLoadig()
    }
    func showEpisodes(_ tvShows: [TVShowDetailCodable]) {
        viewController?.removeLoading()
        viewController?.showEpisodes(tvShows)
    }
    func showError(_ error: Error) {
        viewController?.showError(error)
    }
}
