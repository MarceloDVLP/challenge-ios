import Foundation

extension ServiceAPI {

    func fetchTVShowDetail(id: Int?, completion: @escaping (Result<TVShowModel, Error>) -> Void) {
        if let url = Endpoints.tvShowDetail(id ?? 0).url {
            request(url: url, completion: { result in
                completion(result)
            })
        }
    }
    
    func fetchEpisodeList(id: Int?, completion: @escaping (Result<[Episode], Error>) -> Void) {
        
        if let url = Endpoints.tvShowEpisodeList(id ?? 0).url {
            request(url: url, completion: { result in
                completion(result)
            })
        }
        
    }
}
