//
//  WatchingViewProtocol.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

protocol WatchingViewProtocol: class {
    var presenter: WatchingPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showPosts(with posts: [Watched])
    
    func showUpdatePosts()
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol WatchingPresenterProtocol: class {
    var view: WatchingViewProtocol? { get set }
    var interactor: WatchingInteractorInputProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad(userEntity posts: UserEntity, type: TraktTVAPI.type)
    func image(_ posts: [Watched])
}

protocol WatchingInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrievePosts(_ posts: [Watched])
    func onRetrieveImage()
    func onError()
}

protocol WatchingRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: WatchingRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostList(userEntity posts: UserEntity, type: TraktTVAPI.type)
    func retrieveLoadImageList(_ posts: [Watched])
}

protocol WatchingRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onPostsRetrieved(_ posts: [Watched])
    func onPostsImage()
    func onError()
}

protocol WatchingInteractorInputProtocol: class {
    var presenter: WatchingInteractorOutputProtocol? { get set }
    var remoteDatamanager: WatchingRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrievePostList(userEntity posts: UserEntity, type: TraktTVAPI.type)
    func retrieveUpdatImageList(_ posts: [Watched])
}
