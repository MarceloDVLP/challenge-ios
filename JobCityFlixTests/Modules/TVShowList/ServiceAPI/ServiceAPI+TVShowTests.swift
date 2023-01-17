//
//  ServiceAPI+TVShowTests.swift
//  JobCityFlixTests
//
//  Created by Marcelo Carvalho on 04/09/22.
//

import XCTest
@testable import JobCityFlix

extension ServiceAPITests {
    
    func testRequestTVShowListShouldRequestWithValidURL() {
        let (sut, _, spy) = makeSUT(completeWith: .success(makeValidJSONData()))
        let url = URL(string: "http://api.tvmaze.com/shows?page=1")!
        let page = 1

        sut.fetchTVShowList(page: page, completion: { (result: Result<[TVShowModel], Error>) in
            
        })

        XCTAssertEqual(spy.urls, [url])
    }
    
    func testRequestTVShowListShouldReturnShowsForValidJSONReturn() {
        let (sut, _, spy) = makeSUT(completeWith: .success(makeValidJSONData()))
        let url = URL(string: "http://api.tvmaze.com/shows?page=1")!
        let showsMock = makeJSONMockArray()
        let page = 1

        var showsResult: [TVShowModel] = []
        sut.fetchTVShowList(page: page, completion: { (result: Result<[TVShowModel], Error>) in
            switch result {
            case .success(let shows):
                showsResult = shows
            case .failure(_):
                XCTFail()
            }
        })

        XCTAssertEqual(spy.urls, [url])
        XCTAssertEqual([showsMock], [showsResult])
    }
    
    func testRequestTVShowListShouldReturnErrorForInValidJSONReturn() {
        let (sut, _, _) = makeSUT(completeWith: .success(makeInvalidJSONData()))
        let page = 1

        var errorResult: Error?
        sut.fetchTVShowList(page: page, completion: { (result: Result<[TVShowModel], Error>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let failure):
                errorResult = failure
            }
        })
        
        XCTAssertNotNil(errorResult)
    }
    

}
