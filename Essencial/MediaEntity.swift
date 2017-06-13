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
    var id = 0
    var title = ""
    var year = 0
}

extension MediaEntity: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id       <- map["id"]
        title     <- map["title"]
    }
    
}
//class MediaEntity: MediaItem {
//
//   public var title: String?
//    public var year: Int?
////    var slug: String = ""
////    var banner: NSURL? = nil
////    var fanart: NSURL? = nil
////    var poster: NSURL? = nil    
////    var runtime: Int = 0
////    var tagline: String = ""
////    var summary: String = ""
//
//    public init(title: String?) {
//        self.title = title!
//    }
//    public init() {
//    }
//}
