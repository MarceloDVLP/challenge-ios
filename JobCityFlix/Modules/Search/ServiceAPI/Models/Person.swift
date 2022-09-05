import Foundation

struct Person:Decodable {
    
    let id:Int?
    let url:String?
    let name:String?
    let country:Country?
    let birthday:String?
    let deathday:String?
    let gender:String?
    let image:Media?
    let showCharacter: ShowCharacter?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case url
        case name
        case country
        case birthday
        case deathday
        case gender
        case image
        case showCharacter = "character"

    }
    
    init(_ id: Int) {
        self.id = id
        url = nil
        name = "Mike Vogel"
        country = nil
        birthday = "1979-07-17"
        deathday = nil
        gender = nil
        image = Media(medium: nil, original: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/0/1815.jpg")!)
        
        showCharacter = nil
    }
}

struct ShowCharacter:Decodable {
    let id: Int?
    let name: String?
    let image: Media?
}
//
//  Person.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 03/09/22.
//

import Foundation
