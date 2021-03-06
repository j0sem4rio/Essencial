//
//  WatchListItensInteractor.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

class WatchListItensInteractor: WatchListInteractorInputProtocol {
    
    weak var presenter: WatchListInteractorOutputProtocol?
    var remoteDatamanager: WatchListRemoteDataManagerInputProtocol?
    
    func retrievePostList(type: TraktTVAPI.type) {
        remoteDatamanager?.retrievePostList(type: type)
    }
    
    func retrieveUpdatImageList(_ posts: [WatchList], type: ThemoviedbAPI.typedb) {
        remoteDatamanager?.retrieveLoadImageList(posts, type: type)
    }    
}

extension WatchListItensInteractor: WatchListRemoteDataManagerOutputProtocol {
    
    func onPostsRetrieved(_ posts: [WatchList]) {
        presenter?.didRetrievePosts(posts)
        
    }
    
    func onPostsImage() {
        presenter?.onRetrieveImage()
    }
    
    func onError() {
        presenter?.onError()
    }
    
}
