import XCTest
@testable import JobCityFlix

final class HTTPClientTests: XCTestCase {

    func testRequestReturnsErrorForInvalidURL() {
        let session = URLSession.shared
        let sut = HTTPClient(session: session)
        let url = URL(string: "http://any-url.com")!

        let expectation = expectation(description: "EXP")

        var requestResult: Error?
        sut.request(url: url, completion: { (result: HTTPClient.RequestResult) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                requestResult = error
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(requestResult)
    }
    
    func testRequestReturnsDataForValidURL() {
        let session = URLSession.shared
        let sut = HTTPClient(session: session)
        let url = Endpoints.tvShowList(1).url!

        let expectation = expectation(description: "EXP")

        var dataResult: Data?
        sut.request(url: url, completion: { (result: HTTPClient.RequestResult) in
            switch result {
            case .success(let data):
                dataResult = data
            case .failure(_ ):
                XCTFail()
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(dataResult)
    }
}

