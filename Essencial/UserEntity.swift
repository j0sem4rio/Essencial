//
//  UserEntity.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 12/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import ObjectMapper

struct UserEntity {
    var id = 0
    var name = ""
}

extension UserEntity: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id       <- map["id"]
        name     <- map["name"]
    }
    
}
