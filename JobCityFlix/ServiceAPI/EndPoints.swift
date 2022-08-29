import Foundation

enum Endpoints {
    
    case tvShowList(Int)    
    case tvShowDetail(Int)
    
    var baseURL: String {
        "http://api.tvmaze.com/"
    }

    var url: URL {
        
        switch self {

        case .tvShowList( let page):
            return URL(string: "\(baseURL)shows?page=\(page)")!

        case .tvShowDetail( let id):
            return URL(string: "\(baseURL)show/\(id)")!

        }
    }
}



