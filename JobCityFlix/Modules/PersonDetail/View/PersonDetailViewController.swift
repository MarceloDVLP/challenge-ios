import UIKit

final class PersonDetailViewController: UIViewController {

    private var interactor: PersonDetailInteractorProtocol
    private var tvShowDetail: TVShowCodable!
    private var seasons: [String] = []
    private var selectedSeasonIndex: Int = 0
    
    private lazy var personDetailView: PersonDetailView = {
        let view = PersonDetailView()
        view.delegate = self
        return view
    }()
    
    init(interactor: PersonDetailInteractorProtocol) {
        self.interactor = interactor        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPersonDetailView()
        interactor.viewDidLoad()
        setupNavigationImage("logo-home")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PersonDetailViewController: PersonDetailViewControllerProtocol {
    
    func showLoadig() {
        let loadingView = makeActivityIndicatorView()
        view.addSubview(loadingView)
    }

    func show(_ person: Person) {
        personDetailView.show(person)
    }
    
    func show(_ shows: [TVShowCodable]) {
        personDetailView.show(shows)
    }

    func showError(_ error: Error) {}
    
    func removeLoading() {
        let loadingView = view.subviews.first(where: { type(of: $0.self) == UIActivityIndicatorView.self })
        
        loadingView?.removeFromSuperview()
    }
}

//MARK: Helpers

extension PersonDetailViewController {
    
    private func setupPersonDetailView() {
        view.constrainSubView(view: personDetailView, top: 16, bottom: 0, left: 0, right: 0)
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

extension PersonDetailViewController: PersonDetailViewDelegate {

    func didTapShow(_ tvShow: TVShowCodable) {
        let viewController = TVShowDetailConfigurator.make(tvShow)
        navigationController?.pushViewController(viewController, animated: true)
    }
}


