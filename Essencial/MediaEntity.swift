//
//  MediaEntity.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class MediaEntity: MediaItem {

   public var title: String?
    public var year: Int?
//    var slug: String = ""
//    var banner: NSURL? = nil
//    var fanart: NSURL? = nil
//    var poster: NSURL? = nil    
//    var runtime: Int = 0
//    var tagline: String = ""
//    var summary: String = ""

    public init(title: String?) {
        self.title = title!
    }
    public init() {
    }
}
