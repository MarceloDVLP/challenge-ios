//
//  ServiceAPI.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 28/08/22.
//

import Foundation

final class ServiceAPI {

    public enum ServiceAPIError: Error {
        case clientError
        case serializeError
    }

    let client: HTTPClientProtocol
    
    public init(client: HTTPClientProtocol) {
        self.client = client
    }
}
