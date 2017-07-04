//
//  UserEntity.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 12/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import ObjectMapper

class UserEntity: Mappable {
    var username = ""
    var privatevalue = false
    var name = ""
    var vip = true
    var vip_ep = false
    var ids: [String: String] = [:]
    var joined_at: Date?
    var location = ""
    var about = ""
    var gender = ""
    var age = 0
    var avatar: URL?
    var vip_og = true
    var vip_years = 0
    var account: [String: String] = [:]
    var connections: [String: Bool] = [:]
    var sharing_text: [String: String] = [:]    
    
    required init?(map: Map) {
        
    }
}

extension UserEntity {
    
    func mapping(map: Map) {
         username      <- map["user.username"]
         privatevalue  <- map["user.privatevalue"]
         name          <- map["user.name"]
         vip           <- map["user.vip"]
         vip_ep        <- map["user.vip_ep"]
         ids           <- map["user.ids"]
         joined_at     <- map["user.joined_at"]
         location      <- map["user.location"]
         about         <- map["user.about"]
         gender        <- map["user.gender"]
         age           <- map["user.age"]
         avatar        <- map["user.avatar"]
         vip_og        <- map["user.vip_og"]
         vip_years     <- map["user.vip_years"]
         account       <- map["user.account"]
         connections   <- map["user.connections"]
         sharing_text  <- map["user.sharing_text"]
        
    }
    
}
