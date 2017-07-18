//
//  WatchingRemoteDataManager.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchingRemoteDataManager: WatchingRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: WatchingRemoteDataManagerOutputProtocol?
    
    func retrievePostList(userEntity posts: UserEntity, type: TraktTVAPI.type) {
        TraktTVAPI().watched(userEntity: posts, type: type) { (medias) in
            self.remoteRequestHandler?.onPostsRetrieved(medias)
        }
    }
    func retrieveLoadImageList(_ posts: [Watched]) {
        for medie in posts {
//            ThemoviedbAPI().poster(mediaEntity: medie, completion: { _ in
//                self.remoteRequestHandler?.onPostsImage()
//            })
        }
    }
}
