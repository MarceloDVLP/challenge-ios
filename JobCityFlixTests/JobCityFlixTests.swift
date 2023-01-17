//
//  JobCityFlixTests.swift
//  JobCityFlixTests
//
//  Created by Marcelo Carvalho on 04/09/22.
//

import XCTest
@testable import JobCityFlix

extension XCTestCase {
    
    func makeValidJSONData() -> Data {
        let url = Bundle.main.url(forResource: "TVShowListJSON", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        return jsonData
    }
    
    func makeInvalidJSONData() -> Data {
        let string = ""
        return string.data(using: .utf8)!
    }
    
    func makeJSONMockArray() -> [TVShowModel] {
        let jsonData = makeValidJSONData()
        let shows = try! JSONDecoder().decode([TVShowModel].self, from: jsonData)
        return shows
    }
}
