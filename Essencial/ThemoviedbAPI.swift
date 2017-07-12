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
    
    func poster(mediaEntity: MediaEntity, completion: @escaping (Error?) -> Void ) {
        
        Alamofire.request("https://api.themoviedb.org/3/movie/"+"\(mediaEntity.imdb)"+"?api_key=91186317a48cd2172385401e868c2dea").responseJSON { response in
            if let JSON = response.result.value as? NSDictionary {
                
                if let poster = JSON["poster_path"] as? String {
                    mediaEntity.imageUrl = "https://image.tmdb.org/t/p/w500/"+poster
                    completion(nil)
                }
                
            }
        }
    }
}
