//
//  WatchPattern.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/19/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import SwiftyJSON

class WatchPattern: NSObject {

    func ParserIds(json: [String : JSON]) -> Ids {
        let id: Ids = Ids()
        id.slug = json["slug"]?.stringValue
        id.imdb = json["imdb"]?.stringValue
        id.tmdb = json["tmdb"]?.intValue
        id.tvrage = json["tvrage"]?.intValue
        id.trakt = json["trakt"]?.intValue
        return id
    }
    func ParserShow(json: [String : JSON]) -> Show {
        let show: Show = Show()
        show.title = json["title"]?.stringValue
        show.year = json["year"]?.intValue
        if let ids = json["ids"]?.dictionary {
            show.ids = ParserIds(json: ids)
        }       
        return show
    }
    
    func ParserMovie(json: [String : JSON]) -> Movie {
        let movie: Movie = Movie()
        movie.title = json["title"]?.stringValue
        movie.year = json["year"]?.intValue
        if let ids = json["ids"]?.dictionary {
            movie.ids = ParserIds(json: ids)
        }
        return movie
    }
    
    func jsonDateFormatter() -> DateFormatter {
        let jsonDateFormatter = DateFormatter()
        jsonDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        jsonDateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return jsonDateFormatter
    }
    func parserSeasons(json: [JSON]) -> [Seasons] {
        var sea: [Seasons] = []
        for seasonjosn in json {
            let season: Seasons = Seasons()
            season.number = seasonjosn["number"].intValue
            if let episod =  seasonjosn["episodes"].array {
                var episodArray: [Episodes] = []
                for sepisodjosn in episod {
                    let episodes: Episodes = Episodes()
                    episodes.plays  = sepisodjosn["plays"].intValue
                    episodes.last_watched_at = jsonDateFormatter().date(from: sepisodjosn["last_watched_at"].stringValue)
                    episodArray.append(episodes)
                }
                season.episodes = episodArray
            }
            sea.append(season)
        }
        return sea
    }
}
