//
//  ViewController.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 27/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession.shared
        let service = ServiceAPI(client: HTTPClient(session: session))
        
        service.fetchTVShowList(page: nil, completion: { result in
            switch result {
            case .success(let tvShows):
                print(tvShows ?? [])
            case .failure(let error):
                print(error)
            }
        })
    }
}


