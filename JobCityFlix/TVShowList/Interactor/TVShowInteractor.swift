import Foundation


final class TVShowInteractor: TVShowInteractorProtocol {
    
    private var service: ServiceAPI
    private var presenter: TVShowPresenterProtocol
    private var page: Int
    private var shows: [TVShowCodable]
    
    init (service: ServiceAPI, presenter: TVShowPresenterProtocol) {
        self.service = service
        self.presenter = presenter
        self.page = 0
        self.shows = []
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
