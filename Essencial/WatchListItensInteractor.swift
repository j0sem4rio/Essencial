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
    
    func retrievePostList() {
        remoteDatamanager?.retrievePostList()
    }
    
    func retrieveUpdatImageList(_ posts: [MediaEntity], type: ThemoviedbAPI.typedb) {
        remoteDatamanager?.retrieveLoadImageList(posts, type: type)
    }    
}

extension WatchListItensInteractor: WatchListRemoteDataManagerOutputProtocol {
    
    func onPostsRetrieved(_ posts: [MediaEntity]) {
        presenter?.didRetrievePosts(posts)
        
    }
    
    func onPostsImage() {
        presenter?.onRetrieveImage()
    }
    
    func onError() {
        presenter?.onError()
    }
    
}
