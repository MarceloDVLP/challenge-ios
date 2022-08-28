import Foundation


final class TVShowInteractor: TVShowInteractorProtocol {
    
    private var service: ServiceAPI
    private var presenter: TVShowPresenterProtocol
    
    init (service: ServiceAPI, presenter: TVShowPresenterProtocol) {
        self.service = service
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        presenter.willStartFetch()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchEpisodes()
        }
    }
    
    private func fetchEpisodes() {
        service.fetchTVShowList(page: nil, completion: { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let tvShows):

                DispatchQueue.main.async {
                    self.presenter.showEpisodes(tvShows)
                }
                
            case .failure(let error):
                self.presenter.showError(error)
            }
        })
    }
}
