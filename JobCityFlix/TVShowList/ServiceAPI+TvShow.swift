//
//  ServiceAPI+TvShow.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 28/08/22.
//

import Foundation

extension ServiceAPI {

    func fetchTVShowList(page:Int?, completion: @escaping(Result<[Show], Error>) -> Void) {
        let endpoint = "\(Endpoints.baseURL)\(Endpoints.showList)\(page ?? 0)"
        let url = URL(string: endpoint)!

        client.request(url: url, completion: { result in
            
            switch result {
            case .success(let data):

                let decoder = JSONDecoder()
                do {
                    let showList = try decoder.decode([Show].self, from: data)
                    completion(.success(showList))
                } catch {
                    completion(.failure(ServiceAPIError.clientError))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
