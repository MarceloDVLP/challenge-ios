import Foundation

struct Episode: Decodable {
    
    let id: Int?
    let url: String?
    let number: Int?
    let season: Int?
    let name: String?
    let airdate: String?
    let airtime: String?
    let airstamp: String?
    let runtime: Int?
    let image: Media?
    var summary: String?
    
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
    
    init(name: String?, number: Int?, season: Int?, airtime: String?, runtime: Int?, summary: String?) {
        self.name = name
        self.number = number
        self.season = season
        self.airtime = airtime
        self.runtime = runtime
        self.summary = summary
        self.id = nil
        self.url = nil
        self.airdate = nil
        self.airstamp = nil
        self.image = nil
    }
}
