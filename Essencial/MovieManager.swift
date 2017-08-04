//
//  MovieManager.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 8/3/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import Foundation

open class MovieManager: NSObject {
    
    /// Possible genres used in API call.
    public enum Genres: String {
        case all = "All"
        case action = "Action"
        case adventure = "Adventure"
        case animation = "Animation"
        case comedy = "Comedy"
        case crime = "Crime"
        case disaster = "Disaster"
        case documentary = "Documentary"
        case drama = "Drama"
        case family = "Family"
        case fanFilm = "Fan Film"
        case fantasy = "Fantasy"
        case filmNoir = "Film Noir"
        case history = "History"
        case holiday = "Holiday"
        case horror = "Horror"
        case indie = "Indie"
        case music = "Music"
        case mystery = "Mystery"
        case road = "Road"
        case romance = "Romance"
        case sciFi = "Science Fiction"
        case short = "Short"
        case sports = "Sports"
        case sportingEvent = "Sporting Event"
        case suspense = "Suspense"
        case thriller = "Thriller"
        case war = "War"
        case western = "Western"
        
        public static var array = [all,
                                   action,
                                   adventure,
                                   animation,
                                   comedy,
                                   crime,
                                   disaster,
                                   documentary,
                                   drama,
                                   family,
                                   fanFilm,
                                   fantasy,
                                   filmNoir,
                                   history,
                                   holiday,
                                   horror,
                                   indie,
                                   music,
                                   mystery,
                                   road,
                                   romance,
                                   sciFi,
                                   short,
                                   sports,
                                   sportingEvent,
                                   suspense,
                                   thriller,
                                   war,
                                   western]
        
        public var string: String {
            return rawValue
        }
    }
    /// Possible filters used in API call.
    public enum Filters: String {
        case trending = "trending"
        case popularity = "seeds"
        case rating = "rating"
        case date = "last added"
        case year = "year"
        
        public static let array = [trending, popularity, rating, date, year]
        
        public var string: String {
            switch self {
            case .popularity:
                return "Popular"
            case .year:
                return "New"
            case .date:
                return "Recently Added"
            case .rating:
                return "Top Rated"
            case .trending:
                return "Trending"
            }
        }
    }
}
