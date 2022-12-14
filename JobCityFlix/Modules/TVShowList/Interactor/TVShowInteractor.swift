import Foundation


final class TVShowInteractor: TVShowInteractorProtocol {
    
    private var manager: FavoriteManagerProtocol
    private var service: ServiceAPITVShowProtocol
    private var presenter: TVShowPresenterProtocol
    private var page: Int
    private var shows: [TVShowModel]
    private var isSearching: Bool
    
    init (manager: FavoriteManagerProtocol, service: ServiceAPITVShowProtocol, presenter: TVShowPresenterProtocol) {
        self.service = service
        self.presenter = presenter
        self.page = 0
        self.shows = []
        self.isSearching = false
        self.manager = manager
    }
    
    func viewDidLoad() {
        presenter.willStartFetch()
        fetchEpisodes()
    }
    
    func didFinishPage() {
        fetchEpisodes()
    }
    
    func didTapAddFavorite(_ show: TVShowModel) {
        if manager.isFavorited(id: show.id ?? 0) {
            manager.removeFavorite(with: show.id ?? 0)
        } else {
            manager.save(showName: show.name ?? "",
                         showId: show.id ?? 0,
                         imageURL: show.image?.medium?.absoluteString)
        }
        
    }
    
    private func fetchEpisodes() {
        service.fetchTVShowList(page: page, completion: { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let tvShows):
                self.shows = tvShows
                self.page = self.page + 1
                self.presenter.show(tvShows)
                
            case .failure(let error):
                self.presenter.showError(error)
            }
        })
    }    
}
