//
//  WatchedParser.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/17/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import SwiftyJSON

class WatchedParser: NSObject {
    
    func Parser(json: JSON) -> [Watched] {
        var watcheds: [Watched] = []
        if let array = json.array {
            for j in array {
                let watched = Watched()
                watched.plays = j["plays"].stringValue
                print(j["last_watched_at"].stringValue)
                watched.last_watched_at = jsonDateFormatter().date(from: j["last_watched_at"].stringValue)
                if let shows = j["show"].dictionary {                    
                    let show: Show = Show()
                    show.title = shows["title"]?.stringValue
                    show.year = shows["year"]?.intValue
                    if let ids = shows["ids"]?.dictionary {
                        let id: Ids = Ids()
                        id.slug = ids["slug"]?.stringValue
                        id.imdb = ids["imdb"]?.stringValue
                        id.tmdb = ids["tmdb"]?.intValue
                        id.tvrage = ids["tvrage"]?.intValue
                        id.trakt = ids["trakt"]?.intValue
                        show.ids = id
                    }
                    if let seasons =  j["seasons"].array {
                        for seasonjosn in seasons {
                            let season: Seasons = Seasons()
                            season.number = seasonjosn["number"].intValue
                            
                        }
                    }
                    watched.show = show
                }
                watcheds.append(watched)
            }
        }
        return watcheds
    }
    func jsonDateFormatter() -> DateFormatter {
        let jsonDateFormatter = DateFormatter()
        jsonDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        jsonDateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return jsonDateFormatter
    }
}
