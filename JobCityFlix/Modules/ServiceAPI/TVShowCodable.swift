import Foundation

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
    
    var isFavorited: Bool = false
    
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
        case updated
        case summary
    }
    
    public init(_ id: Int) {
        self.id = id
        
        url = nil
        type = nil
        name = nil
        language = nil
        genres = nil
        status = nil
        runtime = nil
        premiered = nil
        schedule = nil
        rating = nil
        network = nil
        image = nil
        updated = nil
        summary = nil
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
    let medium: URL?
    let original: URL?
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
