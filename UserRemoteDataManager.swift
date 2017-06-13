//
//  UserRemoteDataManager.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import Foundation

class UserRemoteDataManager: UserRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: UserRemoteDataManagerOutputProtocol?
    
    func retrievePostUser() {
        
        TraktTVAPI().profile { (user) in
            self.remoteRequestHandler?.onPostsRetrieved(user)
        }
    }
}
