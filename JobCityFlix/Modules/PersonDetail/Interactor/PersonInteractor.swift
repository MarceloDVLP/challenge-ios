import Foundation


final class PersonDetailInteractor: PersonDetailInteractorProtocol {
    
    private var service: ServiceAPI
    private var presenter: PersonDetailPresenterProtocol
    private var person: Person
    
    init (service: ServiceAPI, presenter: PersonDetailPresenterProtocol, person: Person) {
        self.service = service
        self.presenter = presenter
        self.person = person
    }
    
    func viewDidLoad() {
        self.presenter.show(person)
        presenter.willStartFetch()
        fetchShows()
    }

    private func fetchShows() {
        service.personCast(id: person.id ?? 0, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let shows):
                let tvShows: [TVShowModel] = shows.compactMap({ return $0.embedded?.show })
                self.presenter.show(tvShows)
            case .failure(let error):
                self.presenter.showError(error)
            }
        })
    }
}
