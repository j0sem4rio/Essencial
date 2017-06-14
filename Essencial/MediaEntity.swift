//
//  MediaEntity.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import ObjectMapper

struct MediaEntity {
    var type = ""
    var id = 0
    var title = ""
    var year = 0
    var trakt = 0
    var slug = ""
    var tvdb = ""
    var imdb = ""
    var tmdb = 0
    var tvrage = 0
}

extension MediaEntity: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        type    <- map["type"]
        id      <- map["id"]
        title   <- map["\(type).title"]
        year    <- map["\(type).year"]
        trakt   <- map["\(type).ids.trakt"]
        slug    <- map["\(type).ids.slug"]
        tvdb    <- map["\(type).ids.tvdb"]
        imdb    <- map["\(type).ids.imdb"]
        tmdb    <- map["\(type).ids.tmdb"]
        tvrage  <- map["\(type).ids.tvrage"]
    }
    
}
