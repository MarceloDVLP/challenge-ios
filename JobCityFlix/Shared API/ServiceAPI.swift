//
//  ServiceAPI.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 28/08/22.
//

import Foundation

final class Service {

    let BASEURL = "http://api.tvmaze.com/"
    
    func fetchTVShowList(page:Int?, completion: @escaping(Result<[Show]?, Error>) -> Void) {
        
        let session = URLSession.shared

        let endpoint = "\(BASEURL)\(Endpoints.showList)\(page ?? 0)"
        
        let url = URLRequest(url: URL(string: endpoint)!)
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
                                    
            guard let responseData = data else {
                completion(.failure(ServiceAPIError.connectionError))
                return
            }
            
            guard error == nil else {
                completion(.failure(ServiceAPIError.serverError))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let showList = try decoder.decode([Show].self, from: responseData)
                completion(.success(showList))
            } catch {
                completion(.failure(ServiceAPIError.serverError))
            }
            
        })
        
        task.resume()
    }
}



