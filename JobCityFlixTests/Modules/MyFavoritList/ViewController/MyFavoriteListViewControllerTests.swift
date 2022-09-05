import XCTest
import SnapshotTesting
@testable import JobCityFlix

final class MyFavoriteListViewControllerTests: XCTestCase {

    let devices: [ViewImageConfig] = [
        .iPhoneX(.portrait)
    ]
    
    let record = true
    
    private func makeSUT() -> UINavigationController {
        let manager = FavoriteManagerMock()
        let presenter = MyFavoriteListPresenter()
        
        let interactor = MyFavoriteListInteractor(manager: manager)
        let viewController = MyFavoriteListViewController(interactor: interactor)

        presenter.viewController = viewController
        viewController.interactor = interactor
        interactor.delegate = presenter
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        let tabBar = TabViewController()
        tabBar.setViewControllers([navigation], animated: false)
        viewController.viewDidLoad()
        return navigation
    }
    
    func testTVShowListViewControllerLayout() throws {
        let sut = makeSUT()
        devices.forEach({ device in
            assertSnapshot(matching: sut,
                           as: .image(on: device),
                           record: record)
        })
    }

    class FavoriteManagerMock: FavoriteManagerProtocol {
        func save(showName: String, showId: Int, imageURL: String?) {
            
        }
        
        func fetch() -> [FavoriteEntity] {
            return []
        }
        
        func removeFavorite(with id: Int) {
            
        }
        
        func isFavorited(id: Int) -> Bool {
            return false
        }
        
        
    }
    class ServiceAPIMock: ServiceAPIProtocol {
        var shows: [TVShowCodable] = []
        
        func fetchTVShowList(page: Int?, completion: @escaping (Result<[TVShowCodable], Error>) -> Void) {
            completion(.success(shows))
        }
        
        
    }
}
