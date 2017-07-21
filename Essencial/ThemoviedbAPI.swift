//
//  ThemoviedbAPI.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/12/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//
import UIKit
import Alamofire
import AlamofireObjectMapper

class ThemoviedbAPI {
    
    enum typedb: String {
        case Movies = "movie"
        case Tv = "tv"
    }
    
    func poster(mediaEntity: WatchList, type: ThemoviedbAPI.typedb, completion: @escaping (Error?) -> Void ) {
        var movie_id: String = ""
        if type == .Movies {
            movie_id = mediaEntity.movie.ids.imdb
        } else {
            movie_id = String(mediaEntity.show.ids.tmdb)
        }
        
        Alamofire.request("https://api.themoviedb.org/3/\(type.rawValue)/"+"\(movie_id)"+"?api_key=91186317a48cd2172385401e868c2dea").responseJSON { response in
            if let JSON = response.result.value as? NSDictionary {
                
                if let poster = JSON["poster_path"] as? String {
                    if type == .Movies {
                        mediaEntity.movie.imageUrl = "https://image.tmdb.org/t/p/w500/"+poster
                    } else {
                        mediaEntity.show.imageUrl = "https://image.tmdb.org/t/p/w500/"+poster
                    }
                    completion(nil)
                }
                
            }
        }
    }
    
    func poster(watched: Watched, type: ThemoviedbAPI.typedb, completion: @escaping (Error?) -> Void ) {
        var movie_id: String = ""
        if type == .Movies {
            if let imdb = watched.movie.ids.imdb {
                movie_id = imdb
            }
        } else {
            movie_id = String(watched.show.ids.tmdb)
        }
        
        Alamofire.request("https://api.themoviedb.org/3/\(type.rawValue)/"+"\(movie_id)"+"?api_key=91186317a48cd2172385401e868c2dea").responseJSON { response in
            if let JSON = response.result.value as? NSDictionary {
                
                if let poster = JSON["poster_path"] as? String {
                    if type == .Movies {
                        watched.movie.imageUrl = "https://image.tmdb.org/t/p/w500/"+poster
                    } else {
                        watched.show.imageUrl = "https://image.tmdb.org/t/p/w500/"+poster
                    }
                    completion(nil)
                }
                
            }
        }
    }
}
