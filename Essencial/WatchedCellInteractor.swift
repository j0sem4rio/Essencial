//
//  WatchedCellInteractor.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/26/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchedCellInteractor: WatchedCellInteractorInputProtocol {
    
    weak var presenter: WatchedCellInteractorOutputProtocol?
    var remoteDatamanager: WatchedCellRemoteDataManagerInputProtocol?
    
    func retrieveUpdatImageList(_ posts: Watched, type: ThemoviedbAPI.typedb) {
        remoteDatamanager?.retrieveLoadImageList(posts, type: type)
    }

}

extension WatchedCellInteractor: WatchedCellRemoteDataManagerOutputProtocol {
    
    func onPostsRetrieved(_ posts: Watched) {
        presenter?.didRetrievePosts(posts)
        
    }
    
    func onError() {
        presenter?.onError()
    }
}
