//
//  MyFavoriteManagerTests.swift
//  JobCityFlixTests
//
//  Created by Marcelo Carvalho on 04/09/22.
//

import XCTest
import CoreData
@testable import JobCityFlix

final class MyFavoriteManagerTests: XCTestCase {

    func testSaveShouldSaveOnContext() {
        let context = persistentContainer.viewContext
        
        //GIVEN
        let sut = FavoriteManager(persistentContainer: persistentContainer)
        let name = "Movie"
        let showId = 1
        let imageURL = "http://any-url.com"
        
        //When
        
        sut.save(showName: name, showId: showId, imageURL: imageURL)
        
        //THEN
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteEntity")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "showId = \(showId)")
        let result = try? context.fetch(request) as? [FavoriteEntity]
                
        let resultId = Int(result?.first?.showId ?? 0)
        let resultName = result?.first?.showName ?? ""
        let resultImageURL = result?.first?.imageURL ?? ""

        XCTAssertEqual(resultId, showId)
        XCTAssertEqual(resultName, name)
        XCTAssertEqual(resultImageURL, imageURL)
    }
    
    func testSaveShouldFetchFromContext() {
        //GIVEN
        let sut = FavoriteManager(persistentContainer: persistentContainer)
        let name = "Movie"
        let showId = 1
        let imageURL = "http://any-url.com"
        sut.save(showName: name, showId: showId, imageURL: imageURL)
        sut.save(showName: name, showId: showId, imageURL: imageURL)
        sut.save(showName: name, showId: showId, imageURL: imageURL)

        //WHEN
        let result = sut.fetch()
        
        //THEN
        XCTAssertEqual(result.count, 3)
    }
    
    func testSaveShouldRemoveFromContext() {
        //GIVEN
        let sut = FavoriteManager(persistentContainer: persistentContainer)
        let name = "Movie"
        let showId = 1
        let imageURL = "http://any-url.com"
        sut.save(showName: name, showId: showId, imageURL: imageURL)
        let resultBeforeDelete = sut.fetch().count
        //When
        sut.removeFavorite(with: 1)
        //THEN
        let resultAfterDelete = sut.fetch().count
        
        XCTAssertEqual(resultBeforeDelete, 1)
        XCTAssertEqual(resultAfterDelete, 0)
    }
    
    func testIsFavoriteShouldReturnTrue() {
        //GIVEN
        let sut = FavoriteManager(persistentContainer: persistentContainer)
        let name = "Movie"
        let showId = 1
        let imageURL = "http://any-url.com"
        sut.save(showName: name, showId: showId, imageURL: imageURL)
        //When
        let result = sut.isFavorited(id: showId)
        //THEN
        
        XCTAssertTrue(result)
    }
    
    func testIsFavoriteShouldReturnFalse() {
        //GIVEN
        let sut = FavoriteManager(persistentContainer: persistentContainer)
        let showId = 1
        //When
        let result = sut.isFavorited(id: showId)
        //THEN
        
        XCTAssertFalse(result)
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "CoredataModel")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
