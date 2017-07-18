//
//  WatchListRemoteDataManager.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class WatchListRemoteDataManager: WatchListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: WatchListRemoteDataManagerOutputProtocol?
    
    func retrievePostList() {
        TraktTVAPI().watchList(type: .Shows) { (medias) in
            self.remoteRequestHandler?.onPostsRetrieved(medias)
        }
    }
    func retrieveLoadImageList(_ posts: [MediaEntity], type: ThemoviedbAPI.typedb) {
        for medie in posts {
            ThemoviedbAPI().poster(mediaEntity: medie, type: type, completion: { _ in
                self.remoteRequestHandler?.onPostsImage()
            })
        }
    }
}
