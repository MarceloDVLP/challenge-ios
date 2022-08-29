import Foundation


final class TVShowDetailInteractor: TVShowDetailInteractorProtocol {
    
    private var service: ServiceAPI
    private var presenter: TVShowDetailPresenterProtocol
    private var tvShow: TVShowCodable

    
    init (service: ServiceAPI, presenter: TVShowDetailPresenterProtocol, tvShow: TVShowCodable) {
        self.service = service
        self.presenter = presenter
        self.tvShow = tvShow
    }
    
    func viewDidLoad() {
        presenter.willStartFetch()
        fetchDetail()
    }
    
    private func fetchDetail() {
        service.fetchTVShowDetail(id: tvShow.id ?? 0, completion: { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let tvShow):

                DispatchQueue.main.async {
                    self.presenter.show(tvShow)
                }
                
            case .failure(let error):
                self.presenter.showError(error)
            }
        })
    }
}
