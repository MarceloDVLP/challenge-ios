//
//  HTTPClient.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 28/08/22.
//

import Foundation

final class HTTPClient {
    
    enum HTTPClientError: Error {
        case serverError
        case connectionError
    }
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func request(url: URL, completion: @escaping (Result<Data, HTTPClientError>) -> ()) {
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in

            if error != nil {
                completion(.failure(HTTPClientError.serverError))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(HTTPClientError.serverError))
            }
        })
        
        task.resume()
    }
}
