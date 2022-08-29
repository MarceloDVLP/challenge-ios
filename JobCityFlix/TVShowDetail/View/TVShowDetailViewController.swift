import UIKit


final class TVShowDetailViewController: UIViewController {

    var interactor: TVShowDetailInteractorProtocol
    
    private lazy var tvShowView: TVShowDetailView = {
        return TVShowDetailView()
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
        
        self.title = "JobCityFlix"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TVShowDetailViewController: TVShowDetailViewControllerProtocol {
    
    func showLoadig() {
        let loadingView = makeActivityIndicatorView()
        view.addSubview(loadingView)
        loadingView.startAnimating()
    }

    func show(_ tvShow: TVShowCodable) {
        tvShowView.item = tvShow
        tvShowView.collectionView.reloadData()
    }

    func showError(_ error: Error) {
        
    }
    
    func removeLoading() {
        let loadingView = view.subviews.first(where: { type(of: $0.self) == UIActivityIndicatorView.self })
        
        loadingView?.removeFromSuperview()
    }
}

//MARK: Helpers

extension TVShowDetailViewController {
    
    private func setupTVShowView() {
        view.constrainSubView(view: tvShowView, top: -90, bottom: 0, left: 0, right: 0)
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




