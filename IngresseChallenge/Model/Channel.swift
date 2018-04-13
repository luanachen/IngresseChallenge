//
//  Channel.swift
//  IngresseChallenge
//
//  Created by Luana on 11/04/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import Foundation


typealias Channel = [ChannelElement]

struct ChannelElement: Codable {
    let score: Double
    let show: Show
}

struct Show: Codable {
    let id: Int
    let name: String
    let genres: [String]?
    let premiered: String?
    let image: Image?
    let summary: String?

    enum CodingKeys: String, CodingKey {
        case id, name, genres, premiered, image, summary
    }
}

struct Image: Codable {
    let medium, original: String
}

