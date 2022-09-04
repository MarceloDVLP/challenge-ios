import Foundation

final class ServiceAPI {

    public enum ServiceAPIError: Error {
        case clientError
        case serializeError
    }

    private let client: HTTPClientProtocol
    
    public init(client: HTTPClientProtocol) {
        self.client = client
    }
    
    func request<T: Decodable>(url: URL, completion: @escaping(Result<T, Error>) -> Void) {
        client.request(url: url, completion: { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                completion(self.decode(data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func decode<T: Decodable> (_ data: Data) -> Result<T, Error> {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: data)
            return Result.success(object)
        } catch {
            return Result.failure(ServiceAPIError.clientError)
        }
    }
}
