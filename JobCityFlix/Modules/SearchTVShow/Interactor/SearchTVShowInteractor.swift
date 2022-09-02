import Foundation

protocol SearchShowInteractorProtocol {
    func didSearch(_ query: String)
}

final class SearchShowInteractor: SearchShowInteractorProtocol {

    private var service: ServiceAPI
    private var presenter: SearchShowPresenterProtocol
    private var isSearching: Bool
    private var query: String

    init (service: ServiceAPI, presenter: SearchShowPresenterProtocol) {
        self.service = service
        self.presenter = presenter
        self.isSearching = false
        self.query = ""
    }
 
    func didSearch(_ query: String) {
        guard isSearching || query != self.query else {
            return
        }
        
        self.query = query.lowercased().stripped.trimmingCharacters(in: .whitespacesAndNewlines)
        isSearching = true
        
        service.searchTVShow(query: self.query, completion: { [weak self] result in
        
            guard let self = self else { return }
            
            switch result {
            case .success(let result):

                Thread.executeOnMain() {
                    let tvShows = result.compactMap({ return $0.show })
                    self.presenter.show(tvShows)
                    self.isSearching = false
                }
                
            case .failure(let error):
                self.presenter.show(error)
                self.isSearching = false
            }
        })
    }
}
