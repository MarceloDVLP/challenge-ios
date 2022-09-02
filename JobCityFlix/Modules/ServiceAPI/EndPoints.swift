import Foundation

enum Endpoints {
    
    case tvShowList(Int)    
    case tvShowDetail(Int)
    case tvShowEpisodeList(Int)
    case searchTvShow(String)

    var baseURL: String {
        "http://api.tvmaze.com/"
    }

    var url: URL {
        
        switch self {

        case .tvShowList(let page):
            return URL(string: "\(baseURL)shows?page=\(page)")!

        case .tvShowDetail( let id):
            return URL(string: "\(baseURL)shows/\(id)")!

        case .tvShowEpisodeList( let id):
            return URL(string: "\(baseURL)shows/\(id)/episodes")!
            
        case .searchTvShow( let query):
            return URL(string: "\(baseURL)search/shows?q=\(query)")!

        }
    }
}



