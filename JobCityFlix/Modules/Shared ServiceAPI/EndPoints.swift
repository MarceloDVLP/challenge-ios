import Foundation

enum Endpoints {
    
    case tvShowList(Int)    
    case tvShowDetail(Int)
    case tvShowEpisodeList(Int)
    case searchTvShow(String)
    case searchPeople(String)
    case castCredits(Int)
    
    var baseURL: URLComponents {
        return URLComponents(string:"http://api.tvmaze.com/")!
    }

    var url: URL? {
        
        switch self {

        case .tvShowList(let page):
            var urlComponentes = URLComponents(string: "\(baseURL)shows")
            let params = [URLQueryItem(name: "page", value: String(page))]
            urlComponentes?.queryItems = params
            return urlComponentes?.url
            
        case .tvShowDetail(let id):
            var urlComponentes = URLComponents(string: "\(baseURL)shows/")
            urlComponentes?.path += "\(id)"
            return urlComponentes?.url


        case .tvShowEpisodeList(let id):
            var urlComponentes = URLComponents(string: "\(baseURL)")
            urlComponentes?.path += "shows/\(id)/episodes"
            return urlComponentes?.url

        case .searchTvShow(let query):
            var urlComponentes = URLComponents(string: "\(baseURL)")
            urlComponentes?.path += "search/shows"
            let params = [URLQueryItem(name: "q", value: query)]
            urlComponentes?.queryItems = params
            return urlComponentes?.url
            
        case .searchPeople(let query):
            var urlComponentes = URLComponents(string: "\(baseURL)")
            urlComponentes?.path += "search/people"
            let params = [URLQueryItem(name: "q", value: query)]
            urlComponentes?.queryItems = params
            return urlComponentes?.url
            
        case .castCredits(let id):
            var urlComponentes = URLComponents(string: "\(baseURL)")
            urlComponentes?.path += "people/\(id)/castcredits"
            let params = [URLQueryItem(name: "embed", value: "show")]
            urlComponentes?.queryItems = params
            return urlComponentes?.url
        }
    }
}



