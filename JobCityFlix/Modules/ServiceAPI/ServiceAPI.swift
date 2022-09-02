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
