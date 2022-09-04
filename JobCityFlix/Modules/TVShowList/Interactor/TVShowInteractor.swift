import Foundation


final class TVShowInteractor: TVShowInteractorProtocol {
    
    private var manager: FavoriteManagerProtocol
    private var service: ServiceAPI
    private var presenter: TVShowPresenterProtocol
    private var page: Int
    private var shows: [TVShowCodable]
    private var isSearching: Bool
    
    init (manager: FavoriteManagerProtocol, service: ServiceAPI, presenter: TVShowPresenterProtocol) {
        self.service = service
        self.presenter = presenter
        self.page = 0
        self.shows = []
        self.isSearching = false
        self.manager = manager
    }
    
    func viewDidLoad() {
        presenter.willStartFetch()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchEpisodes()
        }
    }
    
    func didFinishPage() {
        fetchEpisodes()
    }
    
    func didTapAddFavorite(_ show: TVShowCodable) {        
        manager.save(showName: show.name ?? "",
                     showId: show.id ?? 0,
                     imageURL: show.image?.medium?.absoluteString)
    }
    
    private func fetchEpisodes() {
        service.fetchTVShowList(page: page, completion: { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let tvShows):
                self.shows = tvShows
                self.page = self.page + 1
                DispatchQueue.main.async {
                    self.presenter.showEpisodes(tvShows)
                }
                
            case .failure(let error):
                self.presenter.showError(error)
            }
        })
    }    
}
