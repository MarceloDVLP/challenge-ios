import Foundation

struct PersonCastCodable: Decodable {
    var embedded: PersonEmbedCodable?
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct PersonEmbedCodable: Decodable {
    var show: TVShowModel?
}
