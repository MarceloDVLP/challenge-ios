import UIKit

final class SearchShowViewController: UIViewController {
    
    var interactor: SearchShowInteractorProtocol
    
    private lazy var searchView: SearchTVShowView = {
        let searchTVShowView = SearchTVShowView()
        searchTVShowView.delegate = self
        return searchTVShowView
    }()
    
    private var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Enter the tv show name"
        searchController.searchBar.showsSearchResultsButton = true
        searchController.searchBar.tintColor = .white
        searchController.searchBar.image(for: UISearchBar.Icon.search, state: .normal)
        searchController.searchBar.autocapitalizationType = .none
        return searchController
    }()

    init(interactor: SearchShowInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem(title: "Search", imageName: "search-icon")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchTVShowView()
        setupSearchBar()
        setupBackButton()
        view.backgroundColor = Colors.backGroundColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
        searchController.searchBar.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: Private Helpers

extension SearchShowViewController {
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
            
    private func setupSearchTVShowView() {
        view.constrainSubView(view: searchView, left: 0, right: 0)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension SearchShowViewController: SearchShowViewControllerProtocol {
    
    func showLoadig() {
        view.addActivityIndicatorView()
    }
    
    func show(_ tvShows: [TVShowCodable]) {
        searchView.show(tvShows)
    }
    
    func show(_ tvShows: [Person]) {
        searchView.show(tvShows)
    }
    
    func showError(_ error: Error) {
        
    }
    
    func removeLoading() {
        view.removeActivityIndicatorView()
    }
}

extension SearchShowViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, query.count >= 3 else {
            return
            
        }
        
        interactor.didSearch(query)
    }
}

extension SearchShowViewController: SearchTVShowViewDelegate {

    func didSelectCast(_ person: Person) {
        let viewController = PersonDetailConfigurator.make(person)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didSelectShow(_ show: TVShowCodable) {
        let viewController = TVShowDetailConfigurator.make(show)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTapFilter(_ selectedFilter: SearchFilter) {
        let items = SearchFilter.allCases.compactMap({ $0.title })
        let viewController = SingleSelectorViewController(items: items, selectedIndex: selectedFilter.rawValue)
        
        viewController.didSelectItem = { [weak self] index in
            let newFilter = SearchFilter.init(rawValue: index)!
            self?.searchView.show(newFilter)
            self?.interactor.didChangeFilter(newFilter)
            self?.setupSearchBar(for: newFilter, clear: selectedFilter != newFilter)
            self?.searchController.isActive = true
        }
        
        present(viewController, animated: true)
    }
    
    func setupSearchBar(for filter: SearchFilter, clear: Bool) {

        if clear {
            searchController.searchBar.text = nil
        }
        
        switch filter {
        case .actors:
            searchController.searchBar.placeholder = "Enter the Actor name"
        case .tvShows:
            searchController.searchBar.placeholder = "Enter the Tv Show name"
        }
        
    }
}

enum SearchFilter: Int, CaseIterable {

    case tvShows
    case actors
    
    var title: String {
        switch self {
        case .tvShows:
            return "TV Show"
        case .actors:
            return "Cast"
        }
    }
}


