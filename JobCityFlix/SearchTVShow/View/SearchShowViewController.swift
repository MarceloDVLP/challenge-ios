import UIKit

final class SearchShowViewController: UIViewController {
    
    var interactor: SearchShowInteractorProtocol
    
    private lazy var searchView: SearchTVShowView = {
        return SearchTVShowView()
    }()
    
    private var searchController: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = "Enter the tv show name"
        sb.searchBar.searchBarStyle = .minimal
        sb.searchBar.image(for: UISearchBar.Icon.search, state: .normal)
        sb.searchBar.autocapitalizationType = .none
        sb.searchBar.setImage(UIImage(named: "tab-search"), for: .search, state: .normal)
           return sb
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
        view.constrainSubView(view: searchView, top: -90, bottom: 0, left: 0, right: 0)
        
        searchView.didSelectTVShow = { [weak self] tvShow in
            guard let self = self else { return }

            self.navigationController?.pushViewController(TVShowDetailConfigurator.make(tvShow), animated: true)
        }
    }
}


extension SearchShowViewController: SearchShowViewControllerProtocol {
    
    func showLoadig() {
        view.addActivityIndicatorView()
    }
    
    func show(_ tvShows: [TVShowCodable]) {
        searchView.items = tvShows
        searchView.collectionView.reloadData()
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
