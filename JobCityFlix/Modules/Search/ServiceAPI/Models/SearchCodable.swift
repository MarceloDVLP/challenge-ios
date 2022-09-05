import Foundation

public struct SearchShowCodable: Decodable {
    let show: TVShowModel
    let score: Double
    
    enum CodingKeys: String, CodingKey {
        case show
        case score
    }
}

public struct SearchPersonCodable: Decodable {
    let person: Person
    let score: Double
    
    enum CodingKeys: String, CodingKey {
        case person
        case score
    }
}
