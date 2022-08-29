import UIKit



final class TVShowListViewController: UIViewController {

    var interactor: TVShowInteractorProtocol
    
    init(interactor: TVShowInteractor) {
        self.interactor = interactor        
        super.init(nibName: nil, bundle: nil)
        self.title = "Netflix"
        tabBarItem = UITabBarItem(title: "Home",
                                  image: UIImage(named: "tab-home"),
                                  selectedImage: UIImage(named: "tab-home")?.withRenderingMode(.alwaysOriginal))
        
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        interactor.viewDidLoad()
    }
}

extension TVShowListViewController: TVShowListViewControllerProtocol {
    
    func showLoadig() {
        let loadingView = makeActivityIndicatorView()
        view.addSubview(loadingView)
        loadingView.startAnimating()
    }

    func showEpisodes(_ tvShows: [TVShowCodable]) {
        let listView = TVShowListView()
        listView.items = tvShows
        view.constrainSubView(view: listView, top: -90, bottom: 0, left: 0, right: 0)
    }

    func showError(_ error: Error) {
        
    }
    
    func removeLoading() {
        let loadingView = view.subviews.first(where: { type(of: $0.self) == UIActivityIndicatorView.self })
        
        loadingView?.removeFromSuperview()
    }
}

//MARK: Helpers

extension TVShowListViewController {
    
    private func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.center = view.center
        indicator.color = .white
        indicator.style = .large
        return indicator
    }
}




