//
//  HTTPClient.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 28/08/22.
//

import Foundation

protocol HTTPClientProtocol {
    
    func request(url: URL, completion: @escaping (HTTPClient.RequestResult) -> ())
}

public enum HTTPClientError: Error {
    case serverError
    case connectionError
}
 
final class HTTPClient: HTTPClientProtocol {

    private let session: URLSession

    public typealias RequestResult = Result<Data, HTTPClientError>
    
    public enum HTTPClientError: Error {
        case serverError
        case connectionError
    }
        
    init(session: URLSession) {
        self.session = session
    }
    
    func request(url: URL, completion: @escaping (RequestResult) -> ()) {

        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in

            if error != nil, let data = data {
                completion(.success(data))
            } else {
                completion(.failure(HTTPClientError.serverError))
            }
        })
        
        task.resume()
    }
}
