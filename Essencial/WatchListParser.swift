//
//  WatchListParser.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/19/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import SwiftyJSON

class WatchListParser: WatchPattern {

    func Parser(json: JSON) -> [WatchList] {
        var watcheds: [WatchList] = []
        if let array = json.array {
            for j in array {
                let watched = WatchList()
                watched.rank = j["rank"].stringValue
                watched.listed_at = jsonDateFormatter().date(from: j["listed_at"].stringValue)
                if let shows = j["show"].dictionary {
                    watched.show = ParserShow(json: shows)
                    if let seasons =  j["seasons"].array {
                        watched.show.seasons = parserSeasons(json: seasons)
                    }
                }
                
                watcheds.append(watched)
            }
        }
        return watcheds
    }
    
}
