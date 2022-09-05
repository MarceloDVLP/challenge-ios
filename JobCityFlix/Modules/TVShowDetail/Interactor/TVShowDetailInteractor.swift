import Foundation
import UIKit


final class TVShowDetailInteractor: TVShowDetailInteractorProtocol {
    
    private var service: ServiceAPI
    private var presenter: TVShowDetailPresenterProtocol
    private var tvShow: TVShowModel
    private var manager: FavoriteManagerProtocol
    
    init (service: ServiceAPI, manager: FavoriteManagerProtocol, presenter: TVShowDetailPresenterProtocol, tvShow: TVShowModel) {
        self.service = service
        self.presenter = presenter
        self.tvShow = tvShow
        self.manager = manager
    }
    
    func viewDidLoad() {
        presenter.willStartFetch()
        fetchDetail()
        fetchEpisodes()
    }
    
    func didTapFavorite() {
        if let id = tvShow.id, isTVShowFavorited() {
            manager.removeFavorite(with: id)
            presenter.show(tvShow, false)
        } else {
            presenter.show(tvShow, true)
            manager.save(showName: tvShow.name ?? "", showId: tvShow.id ?? 0, imageURL: tvShow.image?.medium?.absoluteString)
        }
    }
    
    func isTVShowFavorited() -> Bool {
        if let id = tvShow.id {
            return manager.isFavorited(id: id)
        } else {
            return false
        }
    }
    
    private func fetchDetail() {
        service.fetchTVShowDetail(id: tvShow.id ?? 0, completion: { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let tvShow):
                self.tvShow = tvShow
                self.presenter.show(tvShow, self.isTVShowFavorited())
                
            case .failure(let error):
                self.presenter.showError(error)
            }
        })
    }

    private func fetchEpisodes() {
        service.fetchEpisodeList(id: tvShow.id ?? 0, completion: { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let episodes):

                DispatchQueue.main.async {
                    self.presenter.show(episodes)
                }
                
            case .failure(let error):
                self.presenter.showError(error)
            }
        })
    }

}
