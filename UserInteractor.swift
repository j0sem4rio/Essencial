//
//  UserInteractor.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

class UserInteractor: UserInteractorInputProtocol {
    
    weak var presenter: UserInteractorOutputProtocol?
    var remoteDatamanager: UserRemoteDataManagerInputProtocol?
    
    func retrievePostUser() {
         remoteDatamanager?.retrievePostUser()
    }
    
}

extension UserInteractor: UserRemoteDataManagerOutputProtocol {    
    
    func onPostsRetrieved(_ posts: UserEntity?) {
        presenter?.didRetrievePosts(posts)
        
    }
    
    func onError() {
        presenter?.onError()
    }
    
}
