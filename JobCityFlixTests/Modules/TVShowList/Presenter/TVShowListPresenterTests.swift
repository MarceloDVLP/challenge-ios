import XCTest
@testable import JobCityFlix

final class TVShowListPresenterTests: XCTestCase {

    func testWillStartFetch() {
        //GIVEN
        let (sut, viewDelegate) = makeSUT()
        
        //WHEN
        sut.willStartFetch()
        
        //THEN
        XCTAssertTrue(viewDelegate.didCallShowLoading)
    }
    
    func testShowTVShowsShouldPresentTVShows() {
        //GIVEN
        let (sut, viewDelegate) = makeSUT()
        
        //WHEN
        let tvShowsMock = makeJSONMockArray()
        sut.show(tvShowsMock)
        
        //THEN
        XCTAssertTrue(viewDelegate.didCallRemoveLoading)
        XCTAssertEqual(viewDelegate.tvShows, tvShowsMock)
    }
    
    func testShowErrorShouldPresentError() {
        //GIVEN
        let (sut, viewDelegate) = makeSUT()
        
        //WHEN
        let error = NSError(domain: "", code: 0, userInfo: nil)
        sut.showError(error)
        
        //THEN
        XCTAssertNotNil(viewDelegate.error)
    }
    func makeSUT() -> (TVShowPresenter, TVShowListViewMock) {
        let presenter = TVShowPresenter()
        let delegateMock = TVShowListViewMock()
        presenter.viewController = delegateMock
        return (presenter, delegateMock)
    }
    
    class TVShowListViewMock: TVShowListViewControllerProtocol {
        var didCallShowLoading: Bool = false
        var didCallRemoveLoading: Bool = false
        var tvShows: [TVShowModel]?
        var error: Error?

        func showLoadig() {
            didCallShowLoading = true
        }
        
        func showEpisodes(_ tvShows: [TVShowModel]) {
            self.tvShows = tvShows
        }
        
        func showError(_ error: Error) {
            self.error = error
        }
        
        func removeLoading() {
            didCallRemoveLoading = true
        }
        
        
    }
}
