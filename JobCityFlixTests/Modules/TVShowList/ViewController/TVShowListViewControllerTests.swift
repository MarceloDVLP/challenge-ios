//
//  TVShowListViewControllerTests.swift
//  JobCityFlixTests
//
//  Created by Marcelo Carvalho on 04/09/22.
//

import XCTest
import SnapshotTesting
@testable import JobCityFlix

final class TVShowListViewControllerTests: XCTestCase {

    let devices: [ViewImageConfig] = [
        .iPhoneX(.portrait)
    ]
    
    let record = true
    
    func testTVShowListViewControllerLayout() throws {
        let sut = makeSUT()
        devices.forEach({ device in
            assertSnapshot(matching: sut,
                           as: .image(on: device),
                           record: record)
        })
    }
    
    func testTVShowCellLayout() throws {
        let view = TVShowListCell(frame: CGRect(x: 0, y: 0, width: TVShowListCell.size.width, height: TVShowListCell.size.height))
        let imageMock = UIImage(named: "4601", in: Bundle(for: TVShowListViewControllerTests.self), compatibleWith: nil)
        
        let tvShow = TVShowCodable(1, name: "Teste Movie")
        view.imageView.image = imageMock
        view.configure(tvShow)
        assertSnapshot(matching: view, as: .image)
    }
    
    func testTVShowMainHeaderLayout() throws {
        let view = TVShowMainHeader(frame: CGRect(x: 0, y: 0, width: 428, height: 555.6))
        let imageMock = UIImage(named: "4601", in: Bundle(for: TVShowListViewControllerTests.self), compatibleWith: nil)
        
        let tvShow = TVShowCodable(1, name: "Teste Movie")
        view.imageView.image = imageMock
        view.configure(tvShow)
        assertSnapshot(matching: view, as: .image)
    }
    
    private func makeSUT() -> UIViewController {
        let service = ServiceAPIMock()
        let manager = FavoriteManagerMock()
        let presenter = TVShowPresenter()
        
        let interactor = TVShowInteractor(manager: manager, service: service, presenter: presenter)
        let viewController = TVShowListViewController(interactor: interactor)

        presenter.viewController = viewController
        viewController.interactor = interactor
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        let tabBar = TabViewController()
        tabBar.setViewControllers([navigation], animated: false)
        viewController.viewDidLoad()
        return navigation
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

extension XCTestCase {
    
    func trackForMemoryLeak(object: AnyObject, file: StaticString = #file, line: UInt = #line) {
        
        addTeardownBlock { [weak object] in
            XCTAssertNil(object, "object should be NIL after tearDownBlock()", file: file, line: line)
        }
    }
}
