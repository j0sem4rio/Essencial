//
//  WatchedCellRemoteDataManager.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/26/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchedCellRemoteDataManager: WatchedCellRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: WatchedCellRemoteDataManagerOutputProtocol?

        func retrieveLoadImageList(_ posts: Watched, type: ThemoviedbAPI.typedb) {
            
                ThemoviedbAPI().poster(watched: posts, type: type, completion: { _ in
                    self.remoteRequestHandler?.onPostsRetrieved(posts)
                })
            
        }
}
