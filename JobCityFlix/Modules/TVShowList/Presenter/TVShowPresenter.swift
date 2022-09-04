import Foundation

final class TVShowPresenter: TVShowPresenterProtocol {

    weak var viewController: TVShowListViewControllerProtocol?
    
    func willStartFetch() {
        Thread.executeOnMain { [weak self] in
            guard let self = self else { return }
            self.viewController?.showLoadig()
        }
    }
    func showEpisodes(_ tvShows: [TVShowCodable]) {
        Thread.executeOnMain { [weak self] in
            guard let self = self else { return }
            self.viewController?.removeLoading()
            self.viewController?.showEpisodes(tvShows)
        }
    }
    func showError(_ error: Error) {
        Thread.executeOnMain { [weak self] in
            guard let self = self else { return }
            self.viewController?.showError(error)
        }
    }
}
