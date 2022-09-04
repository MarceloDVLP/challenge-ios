import Foundation

extension ServiceAPI {

    func fetchTVShowList(page:Int?, completion: @escaping(Result<[TVShowCodable], Error>) -> Void) {
        let url = Endpoints.tvShowList(page ?? 0).url
        request(url: url, completion: { result in
            completion(result)
        })
    }
}
