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
    
}

extension WatchListItensInteractor: WatchListRemoteDataManagerOutputProtocol {
    
    func onPostsRetrieved(_ posts: [MediaEntity]) {
        presenter?.didRetrievePosts(posts)
        
    }
    
    func onError() {
        presenter?.onError()
    }
    
}
