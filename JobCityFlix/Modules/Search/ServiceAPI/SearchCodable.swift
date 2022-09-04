import Foundation

struct SearchShowCodable: Decodable {
    let show: TVShowCodable
    let score: Double
    
    enum CodingKeys: String, CodingKey {
        case show
        case score
    }
}

struct SearchPersonCodable: Decodable {
    let person: Person
    let score: Double
    
    enum CodingKeys: String, CodingKey {
        case person
        case score
    }
}
