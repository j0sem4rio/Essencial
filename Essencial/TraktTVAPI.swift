//
//  TraktTVAPI.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 06/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class TraktTVAPI {
    enum type: String {
        case Movies = "movies"
        case Shows = "shows"
        case Episodes = "episodes"
        case Animes = "animes"
    }
    enum status: String {
        case Watching = "start"
        case Paused = "pause"
        case Finished = "stop"
    }
    let clientId = "f4c95e350153c5ecca6a353ff194cccaa7a7ea095ff88bf325030323bacdf2e0"
    let clientSecret = "a5bfed3ca4bb5dbddd6c2a96260fae52677098d02d9f335769499acf4f779da0"
    let username = "mario_fernandes"
    let redirectURI: String = "urn:ietf:wg:oauth:2.0:oob"
    let defs: UserDefaults = UserDefaults.standard
    
    var headers: HTTPHeaders = [
        "trakt-api-key": "f4c95e350153c5ecca6a353ff194cccaa7a7ea095ff88bf325030323bacdf2e0",
        "Content-Type": "application/json",
        "trakt-api-version": "2"
    ]
    
    public var authorizationURL: URL? {
        guard var components = URLComponents(string: "https://www.trakt.tv/oauth/authorize") else { return nil }
        
        let parameters = [
            "response_type": "code",
            "client_id": clientId,
            "redirect_uri": redirectURI
        ]
        components.queryItems = parameters.map(toQueryItem).flatMap { $0 }
        
        return components.url
    }
    func toQueryItem(key: String, value: String) -> URLQueryItem {
        return URLQueryItem(name: key, value: value)
    }
    
    func scrobble(id: String, progress: Float, type: TraktTVAPI.type, status: TraktTVAPI.status, completion: (_ backgroundImageAsString: [MediaEntity]) -> Void ) {
        
        let credential = defs.string(forKey: "password_preference")
            var parameters = [String: Any]()
            
            if type == .Movies {
                parameters = ["movie": ["ids": ["imdb": id]], "progress": progress * 100.0]
            } else {
                parameters = ["episode": ["ids": ["tvdb": Int(id)!]], "progress": progress * 100.0]
            }

        headers["Authorization"] = "Bearer \(credential ?? "")"
        
        Alamofire.request("https://api.trakt.tv/scrobble/\(status.rawValue)", method: .post, parameters:parameters, headers:headers).responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
    }
    
    func getToken(pin: String, completion: (_ background: Bool) -> Void) {
        let parameters: Parameters = [
            "code": pin,
            "client_id": clientId,
            "redirect_uri": redirectURI,
            "client_secret": clientSecret,
            "grant_type": "authorization_code"
            ]
        Alamofire.request("https://api.trakt.tv/oauth/token", method: .post, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                let dict = json as? NSDictionary
                self.defs.setValue(dict?["access_token"], forKey:"access_token")
                self.defs.setValue(dict?["refresh_token"], forKey:"refresh_token")
                UserDefaults.standard.synchronize()
            }
        }
    }

    func getMovieMeta(imdb: String, completion: (_ backgroundImageAsString: String) -> Void) {
        Alamofire.request("https://api.trakt.tv/movies/\(imdb)",
            parameters: ["extended": "images"],
            headers: ["trakt-api-key": clientId, "trakt-api-version": "2"]).responseJSON { response in
            
            if let json = response.result.value {
                print("JSON: \(json)")
                
            }
        }
    }
    
    func watchList(type: TraktTVAPI.type, completion: @escaping (_ background: [MediaEntity] ) -> Void) {
        let credential = defs.string(forKey: "access_token")
        headers["Authorization"] = "Bearer \(credential ?? "")"
        
        Alamofire.request("https://api.trakt.tv/sync/watchlist/\(type.rawValue)",
                          method: .get,
                          parameters: ["extended": "images"],
                          headers: headers).responseArray(completionHandler: { (response: DataResponse<[MediaEntity]>) in
                            switch response.result {
                            case .success(let posts):
                                completion(posts)
                            case .failure( _):
                                completion([])
                            }
                          })
    }
    func watching(userEntity posts: UserEntity, completion: @escaping (_ background: [MediaEntity] ) -> Void) {
        let slug: String = posts.ids["slug"]!
        Alamofire.request("https://api.trakt.tv/users/\(slug)/watching",
            method: .get,
            parameters: ["extended": "images"],
            headers: headers).responseArray(completionHandler: { (response: DataResponse<[MediaEntity]>) in
                switch response.result {
                case .success(let posts):
                    completion(posts)
                case .failure( _):
                    completion([])
                }
            })
    }
    
    func watched(userEntity posts: UserEntity, type: TraktTVAPI.type, completion: @escaping (_ background: [Watched] ) -> Void) {
        let slug: String = posts.ids["slug"]!
//        Alamofire.request("https://api.trakt.tv/users/\(slug)/watched/\(type.rawValue)",
//            method: .get,
//            headers: headers).responseArray(completionHandler: { (response: DataResponse<[Watched]>) in
//                switch response.result {
//                case .success(let posts):
//                    completion(posts)
//                case .failure( _):
//                    completion([])
//                }
        //            })
        Alamofire.request("https://api.trakt.tv/users/\(slug)/watched/\(type.rawValue)",
            method: .get,
            headers: headers).responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                    if let dataFromString = utf8Text.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                        let json = JSON(data: dataFromString)
                        let parser: WatchedParser = WatchedParser()                        
                        completion(parser.Parser(json: json))
                    }
                }
        }
    }
    
    func getList(completion: @escaping (_ background: [MediaEntity] ) -> Void) {
        
        let credential = defs.string(forKey: "access_token")
        headers["Authorization"] = "Bearer \(credential ?? "")"
        
        Alamofire.request("https://api.trakt.tv/shows/trending",
                          method: .get,
                          parameters: ["extended": "images"],
                          headers: headers).responseArray(completionHandler: { (response: DataResponse<[MediaEntity]>) in
                            switch response.result {
                            case .success(let posts):
                                completion(posts)
                            case .failure( _):
                                completion([])
                            }
                          })
    }
    
    func settings(completion: @escaping (_ background: UserEntity?) -> Void) {
        let credential = defs.string(forKey: "access_token")
        headers["Authorization"] = "Bearer \(credential ?? "")"
        
        Alamofire.request("https://api.trakt.tv/users/settings",
            method: .get,
            parameters: ["extended": "images"],
            headers: headers).responseObject(completionHandler: { (response: DataResponse<UserEntity>) in
                switch response.result {
                case .success(let posts):
                    completion(posts)
                case .failure( _):
                    completion(nil)
                }
            })
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
