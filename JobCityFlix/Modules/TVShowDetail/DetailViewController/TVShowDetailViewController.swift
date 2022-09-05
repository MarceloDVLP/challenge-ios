import UIKit

final class TVShowDetailViewController: UIViewController {

    deinit {
        print("did Release TVShowDetailViewController")
    }

    private var interactor: TVShowDetailInteractorProtocol
    private var tvShowDetail: TVShowModel!
    private var seasons: [String] = []
    private var selectedSeasonIndex: Int = 0
    
    private lazy var tvShowView: TVShowDetailView = {
        let view = TVShowDetailView()
        view.delegate = self
        return view
    }()
    
    init(interactor: TVShowDetailInteractor) {
        self.interactor = interactor        
        super.init(nibName: nil, bundle: nil)

        tabBarItem = makeTabBarItem()
        setupTVShowView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
        setupNavigationImage("logo-home")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TVShowDetailViewController: TVShowDetailViewControllerProtocol {
    
    func showLoadig() {
        let loadingView = makeActivityIndicatorView()
        view.addSubview(loadingView)
    }

    func show(_ tvShow: TVShowModel, _ isFavorited: Bool) {
        tvShowView.tvShow = tvShow
        tvShowView.show(tvShow, isFavorited)
    }
    
    func show(_ episodes: [[Episode]], _ seasons: [String]) {
        self.seasons = seasons
        tvShowView.show(episodes, seasons)
    }

    func showError(_ error: Error) {}
    
    func removeLoading() {
        let loadingView = view.subviews.first(where: { type(of: $0.self) == UIActivityIndicatorView.self })
        
        loadingView?.removeFromSuperview()
    }
}

//MARK: Helpers

extension TVShowDetailViewController {
    
    private func setupTVShowView() {
        view.constrainSubView(view: tvShowView, top: 16, bottom: 0, left: 0, right: 0)
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

extension TVShowDetailViewController: TVShowDetailViewDelegate {

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        showNavigationFor(scrollView)
    }
    
    func didTapEpisode(_ episode: Episode) {
        let viewController = TVShowEPisodeDetailViewController(episode: episode)
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    func didTapSeasonButton() {
        let seasonViewController = SingleSelectorViewController(items: seasons, selectedIndex: selectedSeasonIndex)
        
        seasonViewController.didSelectItem = { [weak self] index in
            self?.selectedSeasonIndex = index
            self?.tvShowView.show(index)
        }
        
        present(seasonViewController, animated: true)
    }
    
    func didTapFavorite() {
        interactor.didTapFavorite() 
    }
}


