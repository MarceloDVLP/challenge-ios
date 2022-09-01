import UIKit


final class TVShowListViewController: UIViewController {

    var interactor: TVShowInteractorProtocol

    private var searchBar: UISearchController = {
           let sb = UISearchController()
           sb.searchBar.placeholder = "Enter the tv show name"
           sb.searchBar.searchBarStyle = .minimal
           return sb
    }()
    
    private lazy var tvShowView: TVShowListView = {
        return TVShowListView()
    }()
    
    init(interactor: TVShowInteractor) {
        self.interactor = interactor        
        super.init(nibName: nil, bundle: nil)
        tabBarItem = makeTabBarItem()
        setupTVShowView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
        
        searchBar.searchResultsUpdater = self
        navigationItem.searchController = searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        tvShowView.navigationController = navigationController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNavigationBar() {
        setupNavigationImage("logo-home")
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    

}

extension TVShowListViewController: TVShowListViewControllerProtocol {
    
    func showLoadig() {
        let loadingView = makeActivityIndicatorView()
        view.addSubview(loadingView)
//        loadingView.startAnimating()
    }

    func showEpisodes(_ tvShows: [TVShowCodable]) {
        tvShowView.items = tvShows
        tvShowView.collectionView.reloadData()
    }

    func showError(_ error: Error) {}
    
    func removeLoading() {
        let loadingView = view.subviews.first(where: { type(of: $0.self) == UIActivityIndicatorView.self })
        
        loadingView?.removeFromSuperview()
    }
}

//MARK: Helpers

extension TVShowListViewController {
    
    private func setupTVShowView() {
        view.constrainSubView(view: tvShowView, top: -90, bottom: 0, left: 0, right: 0)
        
        tvShowView.didSelectTVShow = { [weak self] tvShow in
            guard let self = self else { return }

            self.navigationController?.pushViewController(TVShowDetailConfigurator.make(tvShow), animated: true)
        }
        
        tvShowView.didFinishPage = { [weak self] in
            self?.interactor.didFinishPage()
        }
        
        tvShowView.scrollViewWillBeginDecelerating = { [weak self] scrollView in
            self?.showNavigationFor(scrollView)
        }
    }
    
    private func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        indicator.color = .white
        indicator.style = .large
        return indicator
    }
    
    private func makeTabBarItem() -> UITabBarItem {

        tabBarItem = UITabBarItem(title: "Home",
                                  image: UIImage(named: "tab-home"),
                                  tag: 0)

        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        return tabBarItem
    }
}

extension TVShowListViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, query.count >= 3 else {
            return
            
        }
        
        
        
        interactor.didSearch(query)
    }
}

