import Foundation

protocol SearchShowInteractorProtocol {
    func didSearch(_ query: String)
    func didChangeFilter(_ filter: SearchFilter)
}

final class SearchShowInteractor: SearchShowInteractorProtocol {

    private var service: ServiceAPI
    private var presenter: SearchShowPresenterProtocol
    private var isSearching: Bool
    private var query: String
    private var selectedFilter: SearchFilter
    
    init (service: ServiceAPI, presenter: SearchShowPresenterProtocol) {
        self.service = service
        self.presenter = presenter
        self.isSearching = false
        self.query = ""
        self.selectedFilter = .actors
    }
    
    func didChangeFilter(_ filter: SearchFilter) {
        self.selectedFilter = filter
    }
 
    func didSearch(_ query: String) {
        guard isSearching || query != self.query else {
            return
        }
        
        self.query = query.lowercased().stripped.trimmingCharacters(in: .whitespacesAndNewlines)
        isSearching = true
        
        switch selectedFilter {
        case .tvShows:
            service.searchTVShow(query: self.query, completion: { [weak self] result in
                self?.present(result)
            })

        case .actors:
            service.searchPerson(query: self.query, completion: { [weak self] result in
                self?.present(result)
            })
        }
    }
    
    private func present(_ result: Result<[SearchShowCodable], Error>) {
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
    }
    
    private func present(_ result: ServiceAPI.SearchPersonResult) {
        switch result {
        case .success(let result):

            Thread.executeOnMain() {
                let tvShows = result.compactMap({ return $0.person })
                self.presenter.show(tvShows)
                self.isSearching = false
            }
            
        case .failure(let error):
            self.presenter.show(error)
            self.isSearching = false
        }
    }
}
