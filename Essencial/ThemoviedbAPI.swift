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
    
    func poster(mediaEntity: MediaEntity, type: ThemoviedbAPI.typedb, completion: @escaping (Error?) -> Void ) {
        var movie_id: String = ""
        if type == .Movies {
            movie_id = mediaEntity.imdb
        } else {
            movie_id = String(mediaEntity.tmdb)
        }
        
        Alamofire.request("https://api.themoviedb.org/3/\(type.rawValue)/"+"\(movie_id)"+"?api_key=91186317a48cd2172385401e868c2dea").responseJSON { response in
            if let JSON = response.result.value as? NSDictionary {
                
                if let poster = JSON["poster_path"] as? String {
                    mediaEntity.imageUrl = "https://image.tmdb.org/t/p/w500/"+poster
                    completion(nil)
                }
                
            }
        }
    }
}
