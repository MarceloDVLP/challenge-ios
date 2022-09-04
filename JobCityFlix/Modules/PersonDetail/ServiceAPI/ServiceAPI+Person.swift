import Foundation

extension ServiceAPI {

    typealias PersonCastResult = Result<[PersonCastCodable], Error>
     
    func personCast(id: Int?, completion: @escaping (Result<[PersonCastCodable], Error>) -> Void) {
        let url = Endpoints.castCredits(id ?? 0).url
        request(url: url, completion: { result in
            completion(result)
        })
    }    
}

struct PersonCastCodable: Decodable {
    var embedded: PersonEmbedCodable?
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct PersonEmbedCodable: Decodable {
    var show: TVShowCodable?
    
}
