//
//  WatchingInteractor.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchingInteractor: WatchingInteractorInputProtocol {
    
    weak var presenter: WatchingInteractorOutputProtocol?
    var remoteDatamanager: WatchingRemoteDataManagerInputProtocol?
    
    func retrievePostList(userEntity posts: UserEntity, type: TraktTVAPI.type) {
        remoteDatamanager?.retrievePostList(userEntity: posts, type: type)
    }
    
    func retrieveUpdatImageList(_ posts: [Watched], type: ThemoviedbAPI.typedb) {
        remoteDatamanager?.retrieveLoadImageList(posts, type: type)
    }
}

extension WatchingInteractor: WatchingRemoteDataManagerOutputProtocol {
    
    func onPostsRetrieved(_ posts: [Watched]) {
        presenter?.didRetrievePosts(posts)
        
    }
    
    func onPostsImage() {
        presenter?.onRetrieveImage()
    }
    
    func onError() {
        presenter?.onError()
    }
    
}
