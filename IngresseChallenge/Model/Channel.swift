//
//  Channel.swift
//  IngresseChallenge
//
//  Created by Luana on 11/04/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import Foundation


struct Channel: Codable {
    let id: Int
    let url, name: String
    let genres: [Genre]
    let premiered: String
    let image: Image
    let summary: String

    enum CodingKeys: String, CodingKey {
        case id, url, name, genres, premiered, image, summary
    }
}

enum Genre: String, Codable {
    case action = "Action"
    case adventure = "Adventure"
    case anime = "Anime"
    case comedy = "Comedy"
    case crime = "Crime"
    case drama = "Drama"
    case espionage = "Espionage"
    case family = "Family"
    case fantasy = "Fantasy"
    case history = "History"
    case horror = "Horror"
    case legal = "Legal"
    case medical = "Medical"
    case music = "Music"
    case mystery = "Mystery"
    case romance = "Romance"
    case scienceFiction = "Science-Fiction"
    case sports = "Sports"
    case supernatural = "Supernatural"
    case thriller = "Thriller"
    case war = "War"
    case western = "Western"
}

struct Image: Codable {
    let medium, original: String
}

enum Name: String, Codable {
    case canada = "Canada"
    case france = "France"
    case japan = "Japan"
    case unitedKingdom = "United Kingdom"
    case unitedStates = "United States"
}
