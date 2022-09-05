//
//  MyFavoritePresenterTests.swift
//  JobCityFlixTests
//
//  Created by Marcelo Carvalho on 04/09/22.
//

import XCTest
@testable import JobCityFlix

final class MyFavoritePresenterTests: XCTestCase {

  
    func testShowShouldShow() {
        //GIVEN
        let presenter = MyFavoriteListPresenter()
        let delegateMock = MockDelegate()
        presenter.viewController = delegateMock
        
        //WHEN
        presenter.show([])
        
        //THEN
        XCTAssertEqual(delegateMock.items, [])
    }
    
    class MockDelegate: MyFavoriteListPresenterDelegate {

        var items: [FavoriteEntity]?
        func show(_ favorites: [FavoriteEntity]) {
            self.items = favorites
        }
    }
}
