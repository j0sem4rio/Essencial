//
//  WatchedParser.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/17/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import SwiftyJSON

class WatchedParser: WatchPattern {
    
    func Parser(json: JSON) -> [Watched] {
        var watcheds: [Watched] = []
        if let array = json.array {
            for j in array {
                let watched = Watched()
                watched.plays = j["plays"].stringValue
                print(j["last_watched_at"].stringValue)
                watched.last_watched_at = jsonDateFormatter().date(from: j["last_watched_at"].stringValue)
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
