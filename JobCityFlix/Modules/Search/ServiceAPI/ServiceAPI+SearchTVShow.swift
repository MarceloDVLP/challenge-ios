import Foundation

extension ServiceAPI {

    public typealias SearchPersonResult = Result<[SearchPersonCodable], Error>
    public typealias SearchShowResult = Result<[SearchShowCodable], Error>

    func searchPerson(query: String, completion: @escaping(SearchPersonResult) -> Void) {
        let url = Endpoints.searchPeople(query).url
        request(url: url, completion: { (result: Result<[SearchPersonCodable], Error>) in
            completion(result)
        })
    }
    
    func searchTVShow(query: String, completion: @escaping(SearchShowResult) -> Void) {
        let url = Endpoints.searchTvShow(query).url
        
        request(url: url, completion: { result in
            completion(result)
        })
    }
}


