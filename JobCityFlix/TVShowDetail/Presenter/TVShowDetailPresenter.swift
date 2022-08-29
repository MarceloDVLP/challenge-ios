import Foundation

final class TVShowDetailPresenter: TVShowDetailPresenterProtocol {

    weak var viewController: TVShowDetailViewControllerProtocol?
    
    func willStartFetch() {
        viewController?.showLoadig()
    }
    func show(_ tvShow: TVShowCodable) {
        viewController?.removeLoading()
        viewController?.show(tvShow)
    }
    func showError(_ error: Error) {
        viewController?.showError(error)
    }
}
