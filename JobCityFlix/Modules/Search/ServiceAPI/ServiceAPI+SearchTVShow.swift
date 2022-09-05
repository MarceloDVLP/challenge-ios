import Foundation

extension ServiceAPI: ServiceAPISearch {


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

public typealias SearchPersonResult = Result<[SearchPersonCodable], Error>
public typealias SearchShowResult = Result<[SearchShowCodable], Error>

protocol ServiceAPISearch {

    func searchPerson(query: String, completion: @escaping(SearchPersonResult) -> Void)
    func searchTVShow(query: String, completion: @escaping(SearchShowResult) -> Void)
}


