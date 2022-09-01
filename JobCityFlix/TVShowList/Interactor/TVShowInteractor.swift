import Foundation


final class TVShowInteractor: TVShowInteractorProtocol {
    
    private var service: ServiceAPI
    private var presenter: TVShowPresenterProtocol
    private var page: Int
    private var shows: [TVShowCodable]
    private var isSearching: Bool
    
    init (service: ServiceAPI, presenter: TVShowPresenterProtocol) {
        self.service = service
        self.presenter = presenter
        self.page = 0
        self.shows = []
        self.isSearching = false
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
    
    func didSearch(_ query: String) {
        isSearching = true
        service.searchTVShow(query: query, completion: { [weak self] result in
        
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                                
                self.shows = result.compactMap({ return  $0.show })

                DispatchQueue.main.async {
                    self.presenter.showEpisodes(self.shows)
                    self.isSearching = false
                }
                
            case .failure(let error):
                self.presenter.showError(error)
                self.isSearching = false
            }
        })
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
