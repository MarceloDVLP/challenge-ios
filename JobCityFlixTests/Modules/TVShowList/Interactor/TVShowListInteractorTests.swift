//
//  TvShowListInteractorTests.swift
//  JobCityFlixTests
//
//  Created by Marcelo Carvalho on 04/09/22.
//

import XCTest
@testable import JobCityFlix

final class TVShowListInteractorTests: XCTestCase {

    
    func testShouldStartToFetchWhenViewDidLoad() {
        //GIVEN
        let (sut, presenterMock, _) = makeSUT()
        
        //WHEN
        sut.viewDidLoad()
        
        //THEN
        XCTAssertEqual(presenterMock.didCallWillStartFetch, true)
    }
    
    func testFetchTVShowsShouldCompleteWithSucessWhenServiceReturnsTVShows() {
        //GIVEN
        let (sut, presenterMock, serviceMock) = makeSUT()
        let showsMock = makeJSONMockArray()
        serviceMock.expectedResult = .success(showsMock)
        serviceMock.shows = showsMock
        //WHEN
        sut.viewDidLoad()
        
        //THEN
        XCTAssertEqual(presenterMock.tvShows, showsMock)
    }
    
    func testFetchTVShowsShouldCompleteWithErrorWhenServiceReturnsError() {
        //GIVEN
        let (sut, presenterMock, serviceMock) = makeSUT()
        
        let error = NSError(domain: "", code: 0)
        serviceMock.expectedResult = .failure(error)
        //WHEN
        sut.viewDidLoad()
        
        //THEN
        XCTAssertNotNil(presenterMock.error)
    }
    
    func testePaginationOnListShouldFetchEpisodes() {
        //GIVEN
        let (sut, _, serviceMock) = makeSUT()
        serviceMock.expectedResult = .success([])
        //WHEN
        sut.viewDidLoad()
        sut.didFinishPage()
        
        //THEN
        XCTAssertEqual(serviceMock.page, 1)
    }
    
    func makeSUT() -> (TVShowInteractor, PresenterMock, ServiceAPIMock) {
        let managerMock = ManagerMock()
        let serviceAPIMock = ServiceAPIMock()
        let presenterMock = PresenterMock()
        let sut = TVShowInteractor(manager: managerMock, service: serviceAPIMock, presenter: presenterMock)
        return (sut, presenterMock, serviceAPIMock)
    }

    class ManagerMock: FavoriteManagerProtocol {
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
    
    class ServiceAPIMock: ServiceAPITVShowProtocol {
        var page: Int?
        var shows: [TVShowModel] = []
        var expectedResult: Result<[TVShowModel], Error>?
        func fetchTVShowList(page: Int?, completion: @escaping (Result<[TVShowModel], Error>) -> Void) {
            self.page = page
            
            if let expectedResult = expectedResult {
                completion(expectedResult)
            }
        }
    }
    
    class PresenterMock: TVShowPresenterProtocol {
        var didCallWillStartFetch: Bool = false
        var tvShows: [TVShowModel]?
        var error: Error?
        
        func willStartFetch() {
            didCallWillStartFetch = true
        }
        
        func show(_ tvShows: [TVShowModel]) {
            self.tvShows = tvShows
        }
        
        func showError(_ error: Error) {
            self.error = error
        }
    }
}
