//
//  TVShowEpisodeDetailViewController.swift
//  JobCityFlixTests
//
//  Created by Marcelo Carvalho on 04/09/22.
//

import XCTest
import SnapshotTesting
@testable import JobCityFlix

class TVShowEpisodeDetailViewController: XCTestCase {
    
    let devices: [ViewImageConfig] = [
        .iPhoneX(.portrait)
    ]
    
    let record = false


    func testTVShowListViewControllerLayout() throws {
        let sut = makeSUT()
        let imageMock = UIImage(named: "4601", in: Bundle(for: TVShowListViewControllerTests.self), compatibleWith: nil)

        sut.imageView.image = imageMock
        
        devices.forEach({ device in
            assertSnapshot(matching: sut,
                           as: .image(on: device),
                           record: record)
        })
    }

    private func makeSUT() -> TVShowEPisodeDetailViewController {
      let episode = Episode(name: "Episodio", number: 1, season: 1, airtime: "20:00", runtime: 60, summary: "Teste Summary")
      return TVShowEPisodeDetailViewController(episode: episode)
    }

}
