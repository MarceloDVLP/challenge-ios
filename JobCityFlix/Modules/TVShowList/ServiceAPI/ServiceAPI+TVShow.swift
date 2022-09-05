import Foundation

typealias TVShowListResult = (Result<[TVShowModel], Error>)->()

protocol ServiceAPITVShowProtocol {
    func fetchTVShowList(page:Int?, completion: @escaping (TVShowListResult))
}

extension ServiceAPI: ServiceAPITVShowProtocol {

    func fetchTVShowList(page:Int?, completion: @escaping(TVShowListResult)) {
        if let url = Endpoints.tvShowList(page ?? 0).url {
            request(url: url, completion: { result in
                completion(result)
            })
        }
    }
}
