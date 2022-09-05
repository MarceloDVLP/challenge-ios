import UIKit


final class TVShowListViewController: UIViewController {

    var interactor: TVShowInteractorProtocol
    
    private lazy var tvShowView: TVShowListView = {
        return TVShowListView()
    }()
    
    init(interactor: TVShowInteractor) {
        self.interactor = interactor        
        super.init(nibName: nil, bundle: nil)
        setupTVShowView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItem(title: "Home", imageName: "tab-home")
        interactor.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        tvShowView.navigationController = navigationController
    }
        
    func setupNavigationBar() {
        setupNavigationImage("logo-home")
        setupBackButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TVShowListViewController: TVShowListViewControllerProtocol {
    
    func showLoadig() {
        view.addActivityIndicatorView()
    }

    func showEpisodes(_ tvShows: [TVShowModel]) {
        tvShowView.items = tvShows
        tvShowView.collectionView.reloadData()
    }

    func showError(_ error: Error) {}
    
    func removeLoading() {
        view.removeActivityIndicatorView()
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
        
        tvShowView.didFavoriteTVShow = { [weak self] show in
            self?.interactor.didTapAddFavorite(show)
        }
    }
}
