import XCTest
@testable import JobCityFlix

final class ServiceAPITests: XCTestCase {

    func testRequestMakeRequestsWithValidURL() {
        let (sut, url, spy) = makeSUT(completeWith: .success(makeValidJSONData()))
        
        sut.request(url: url, completion: { (result: Result<TVShowCodable, Error>) in  })
        
        XCTAssertEqual(spy.urls, [url])
    }
    
    func testRequestShouldCompleteWithFailureWhenClientReturnsError() throws {
        
        //GIVEN
        let (sut, url, _) = makeSUT(completeWith: .failure(.serverError))

        //WHEN
        var error: Error?
        sut.request(url: url, completion: { (result: Result<TVShowCodable, Error>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let failure):
                error = failure
            }
        })
        
        XCTAssertNotNil(error, "request should complete with error")
    }
    
    func testRequestShouldCompleteWithErrorWhenClientReturnsValidJSONData() throws {
        //GIVEN
        let jsonData = makeValidJSONData()
        let (sut, urlAPI, _) = makeSUT(completeWith: .success(jsonData))

        //WHEN
        var shows: [TVShowCodable] = []
        
        sut.request(url: urlAPI, completion: { (result: Result<[TVShowCodable], Error>) in
            switch result {
            case .success(let result):
                shows = result
            case .failure(let error):
                print(error)
            }
        })
        
        XCTAssertTrue(shows.count > 0, "request should complete with success and return shows array")
    }

    
    func testRequestShouldCompleteWithSuccessWhenClientReturnsInvalidJSONData() throws {
        //GIVEN
        let jsonData = makeInvalidJSONData()
        let (sut, urlAPI, _) = makeSUT(completeWith: .success(jsonData))

        //WHEN
        var shows: [TVShowCodable] = []
        var errorResult: Error?
        
        sut.request(url: urlAPI, completion: { (result: Result<[TVShowCodable], Error>) in
            switch result {
            case .success(let result):
                shows = result
            case .failure(let error):
                errorResult = error
            }
        })
        
        XCTAssertTrue(shows.count == 0, "request should complete with success and return empty array")
        XCTAssertNotNil(errorResult, "error should be not nil")
    }
    
    //MARK: Helpers methods and Mocks 
    
    func makeSUT(completeWith result: HTTPClient.RequestResult) -> (ServiceAPI, URL, ClientHTPPSpy) {
        let clientSPY = ClientHTPPSpy(result: result)
        let sut = ServiceAPI(client: clientSPY)
        let url = URL(string: "http://any-url.com")!
        return (sut, url, clientSPY)
    }
    
    class ClientHTPPSpy: HTTPClientProtocol {

        let result: HTTPClient.RequestResult!
        var urls: [URL] = []
        init(result: HTTPClient.RequestResult) {
            self.result = result
        }
        
        func request(url: URL, completion: @escaping (HTTPClient.RequestResult) -> ()) {
            urls.append(url)
            completion(result)
        }
    }
}


