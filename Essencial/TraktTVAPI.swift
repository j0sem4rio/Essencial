//
//  TraktTVAPI.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 06/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import Alamofire

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
    
    func scrobble(id: String, progress: Float, type: TraktTVAPI.type, status: TraktTVAPI.status, completion: (_ backgroundImageAsString: [MediaItem]) -> Void ) {
        
        let credential = defs.string(forKey: "password_preference")
            var parameters = [String: Any]()
            
            if type == .Movies {
                parameters = ["movie": ["ids": ["imdb": id]], "progress": progress * 100.0]
            } else {
                parameters = ["episode": ["ids": ["tvdb": Int(id)!]], "progress": progress * 100.0]
            }
        let headers: HTTPHeaders = [
            "trakt-api-key": self.clientId,
            "Content-Type": "application/json",
            "trakt-api-version": "2",
            "Authorization": "Bearer \(credential ?? "")"
        ]
        
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
    func getList(completion: (_ background: [MediaItem] ) -> Void) {
        
        let credential = defs.string(forKey: "password_preference")
        let headers = [
            "trakt-api-key": self.clientId,
            "Accept": "application/json",
            "trakt-api-version": "2",
            "Authorization": "Bearer \(credential ?? "")"
        ]
        
        Alamofire.request("https://api.trakt.tv/shows/trending",
                        method: .get,
            parameters: ["extended": "images"],
            headers: headers).responseJSON { response in
                
                if let data = response.result.value {
//                    let data = text.data(using: .utf8)
                    var names = [String]()
                    
                    do {
                        
                       let d = try JSONSerialization.data(withJSONObject: data, options: [])
                       let json = try JSONSerialization.jsonObject(with: d, options: []) as? [String: Any]
                        print(json)
                        
                    } catch {
                        print("Error deserializing JSON: \(error)")
                    }
                    
                }
        }
        
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
