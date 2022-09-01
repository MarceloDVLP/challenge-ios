import Foundation

extension ServiceAPI {

    func searchTVShow(query: String, completion: @escaping(Result<[SearchCodable], Error>) -> Void) {
        let url = Endpoints.searchTvShow(query).url
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
    
    func decode (_ data: Data) -> Result<[SearchCodable], Error> {
        let decoder = JSONDecoder()
        do {
            let showList = try decoder.decode([SearchCodable].self, from: data)
            return Result.success(showList)
        } catch {
            return Result.failure(ServiceAPIError.clientError)
        }
    }
}
