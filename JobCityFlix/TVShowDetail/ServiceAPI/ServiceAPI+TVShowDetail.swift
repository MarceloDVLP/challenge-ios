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
    
    func fetchEpisodeList(id: Int?, completion: @escaping (Result<[Episode], Error>) -> Void) {
        let url = Endpoints.tvShowEpisodeList(id ?? 0).url
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
    
    func decode(_ data: Data) -> Result<TVShowCodable, Error> {
        let decoder = JSONDecoder()
        do {
            let showList = try decoder.decode(TVShowCodable.self, from: data)
            return Result.success(showList)
        } catch let error {
            print(error.localizedDescription)
            return Result.failure(ServiceAPIError.clientError)
        }
    }
    
    func decode(_ data: Data) -> Result<[Episode], Error> {
        let decoder = JSONDecoder()
        do {
            let showList = try decoder.decode([Episode].self, from: data)
            return Result.success(showList)
        } catch let error {
            print(error.localizedDescription)
            return Result.failure(ServiceAPIError.clientError)
        }
    }
}



struct Episode: Decodable {
    
    let id:Int?
    let url:String?
    let number:Int?
    let season:Int?
    let name:String?
    let airdate:String?
    let airtime:String?
    let airstamp:String?
    let runtime:Int?
    let image:Media?
    var summary:String?
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case number
        case season
        case name
        case airdate
        case airtime
        case airstamp
        case runtime
        case image
        case summary
    }
}
