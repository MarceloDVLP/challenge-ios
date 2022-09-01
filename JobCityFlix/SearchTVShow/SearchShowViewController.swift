import UIKit

final class SearchShowViewController: UIViewController {

    var interactor: SearchShowInteractorProtocol
    
    private lazy var searchView: SearchTVShowView = {
        return SearchTVShowView()
    }()
    private var searchBar: UISearchController = {
           let sb = UISearchController()
           sb.searchBar.placeholder = "Enter the tv show name"
           sb.searchBar.searchBarStyle = .minimal
           return sb
    }()

    init(interactor: SearchShowInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = makeTabBarItem()
        setupSearchTVShowView()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupSearchBar() {
        searchBar.searchResultsUpdater = self
        navigationItem.searchController = searchBar
    }
    
    func setupNavigationBar() {
        setupNavigationImage("logo-home")
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func makeTabBarItem() -> UITabBarItem {

        tabBarItem = UITabBarItem(title: "Search",
                                  image: UIImage(named: "search-icon"),
                                  tag: 0)

        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        return tabBarItem
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
        let loadingView = makeActivityIndicatorView()
        view.addSubview(loadingView)
    }
    
    func show(_ tvShows: [TVShowCodable]) {
        searchView.items = tvShows
        searchView.collectionView.reloadData()
    }
    
    func showError(_ error: Error) {
        
    }
    
    func removeLoading() {
        let loadingView = view.subviews.first(where: { type(of: $0.self) == UIActivityIndicatorView.self })
        
        loadingView?.removeFromSuperview()

    }
}

extension SearchShowViewController {
    
    private func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        indicator.color = .white
        indicator.style = .large
        return indicator
    }
}

extension SearchShowViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, query.count >= 3 else {
            return
            
        }
        
        interactor.didSearch(query)
    }
}
