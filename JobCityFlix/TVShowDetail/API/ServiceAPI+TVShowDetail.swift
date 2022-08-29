import Foundation

extension ServiceAPI {

    func fetchTVShowDetail(id: Int?, completion: @escaping (Result<TVShowCodable, Error>) -> Void) {
        let url = Endpoints.tvShowDetail(id ?? 0).url
        client.request(url: url, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(self.decode(data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func decode (_ data: Data) -> Result<TVShowCodable, Error> {
        let decoder = JSONDecoder()
        do {
            let showList = try decoder.decode(TVShowCodable.self, from: data)
            return Result.success(showList)
        } catch {
            return Result.failure(ServiceAPIError.clientError)
        }
    }
}


