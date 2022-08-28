//
//  ServiceAPI+TvShow.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 28/08/22.
//

import Foundation

extension ServiceAPI {

    func fetchTVShowList(page:Int?, completion: @escaping(Result<[TVShowCodable], Error>) -> Void) {
        let endpoint = "\(Endpoints.baseURL)\(Endpoints.showList)\(page ?? 0)"
        let url = URL(string: endpoint)!

        client.request(url: url, completion: { result in
            
            switch result {
            case .success(let data):

                let decoder = JSONDecoder()
                do {
                    let showList = try decoder.decode([TVShowCodable].self, from: data)
                    completion(.success(showList))
                } catch {
                    completion(.failure(ServiceAPIError.clientError))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
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
//    let schedule:Schedule?
//    let rating:Rating?
//    let network:Network?
//    let image:Media?
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
//        case schedule
//        case rating
//        case network
//        case image
        case summary
        case updated
    }
    
}
