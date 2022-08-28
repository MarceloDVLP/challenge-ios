import Foundation

extension ServiceAPI {

    func fetchTVShowList(page:Int?, completion: @escaping(Result<[TVShowCodable], Error>) -> Void) {
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
    
    func decode (_ data: Data) -> Result<[TVShowCodable], Error> {
        let decoder = JSONDecoder()
        do {
            let showList = try decoder.decode([TVShowCodable].self, from: data)
            return Result.success(showList)
        } catch {
            return Result.failure(ServiceAPIError.clientError)
        }
    }
}


struct TVShowCodable: Decodable {
    
    let id:Int?
    let url:String?
    let type:String?
    let name:String?
    let language:String?
    let genres:[String]?
    let status:String?
    let runtime:Int?
    let premiered:String?
    let schedule:Schedule?
    let rating:Rating?
    let network:Network?
    let image:Media?
    let summary:String?
    let updated:Int?
    var premierDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: premiered ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case type
        case name
        case language
        case genres
        case status
        case runtime
        case premiered
        case schedule
        case rating
        case network
        case image
        case summary
        case updated
    }
    
}

struct Schedule:Decodable {
    let time:String?
    let days:[String]?
}

struct Rating:Decodable {
    let average:Double?
}

struct Media:Decodable {
    let medium:String?
    let original:String?
}

struct Network:Decodable {
    let id:Int?
    let name:String?
    let country: Country?
}

struct Country:Decodable {
    let name:String?
    let code:String?
    let timezone:String?
}
