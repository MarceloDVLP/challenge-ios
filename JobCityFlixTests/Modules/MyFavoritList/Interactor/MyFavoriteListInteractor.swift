//
//  MyFavoriteListInteractor.swift
//  JobCityFlixTests
//
//  Created by Marcelo Carvalho on 04/09/22.
//

import XCTest
@testable import JobCityFlix

final class MyFavoriteListInteractorTests: XCTestCase {

    func testViewWillAppearShouldShowFavoriteItems() {
        //GIVEN
        let delegateMock = DelegateMock()
        let managerSpy = FavoriteManagerSpy()
        let sut = MyFavoriteListInteractor(manager: managerSpy)
        sut.delegate = delegateMock
        //WHEN
        sut.viewWillAppear()
        
        //THEN
        XCTAssertTrue(managerSpy.didCallFetch)
        XCTAssertTrue(delegateMock.didShow)
    }
    

    class DelegateMock: MyFavoriteListInteractorDelegate {
        var favorites: [FavoriteEntity]?
        var didShow: Bool = false
        func show(_ favorites: [FavoriteEntity]) {
            didShow = true
            self.favorites = favorites
        }
    }
    
    class FavoriteManagerSpy: FavoriteManagerProtocol {
        
        var didCallFetch: Bool = false
        
        func save(showName: String, showId: Int, imageURL: String?) {
            
        }
        
        func fetch() -> [FavoriteEntity] {
            didCallFetch = true
            return []
        }
        
        func removeFavorite(with id: Int) {
            
        }
        
        func isFavorited(id: Int) -> Bool {
            return false
        }
    }
}
