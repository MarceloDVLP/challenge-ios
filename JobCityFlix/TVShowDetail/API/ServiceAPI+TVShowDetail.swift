import Foundation

extension ServiceAPI {

    func fetchTVShowDetail(page:Int?, completion: @escaping(Result<[TVShowDetailCodable], Error>) -> Void) {
        let url = Endpoints.tvShowList(page ?? 0).url
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
    
    func decode (_ data: Data) -> Result<[TVShowDetailCodable], Error> {
        let decoder = JSONDecoder()
        do {
            let showList = try decoder.decode([TVShowDetailCodable].self, from: data)
            return Result.success(showList)
        } catch {
            return Result.failure(ServiceAPIError.clientError)
        }
    }
}


struct TVShowDetailCodable: Decodable {
    
}
