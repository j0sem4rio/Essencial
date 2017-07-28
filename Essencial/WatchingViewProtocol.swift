//
//  WatchingViewProtocol.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

protocol WatchingViewProtocol: class {
    var presenter: WatchedPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showPosts(with posts: [Watched])
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}
protocol WatchedCellProtocol: class {
    func showUpdatePosts(_ posts: Watched)
}

protocol WatchedCellPresenterProtocol: class {
    var cell: WatchedCellProtocol? { get set }
    var interactor: WatchedCellInteractorInputProtocol? { get set }
    func image(_ posts: Watched, type: ThemoviedbAPI.typedb)
}

protocol WatchedPresenterProtocol: class {
    var view: WatchingViewProtocol? { get set }
    var interactor: WatchingInteractorInputProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad(userEntity posts: UserEntity, type: TraktTVAPI.type)
}

protocol WatchedCellInteractorOutputProtocol: class {
    func didRetrievePosts(_ posts: Watched)
    func onError()
}
protocol WatchingInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrievePosts(_ posts: [Watched])
    func onError()
}

protocol WatchingRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: WatchingRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostList(userEntity posts: UserEntity, type: TraktTVAPI.type)
//    func retrieveLoadImageList(_ posts: [Watched], type: ThemoviedbAPI.typedb)
}
protocol WatchedCellRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: WatchedCellRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveLoadImageList(_ posts: Watched, type: ThemoviedbAPI.typedb)
}
protocol WatchedCellRemoteDataManagerOutputProtocol: class {
    func onPostsRetrieved(_ posts: Watched)
    func onError()
}

protocol WatchingRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onPostsRetrieved(_ posts: [Watched])
    func onError()
}
protocol WatchedCellInteractorInputProtocol: class {
    var presenter: WatchedCellInteractorOutputProtocol? { get set }
    var remoteDatamanager: WatchedCellRemoteDataManagerInputProtocol? { get set }
    func retrieveUpdatImageList(_ posts: Watched, type: ThemoviedbAPI.typedb)
}
protocol WatchingInteractorInputProtocol: class {
    var presenter: WatchingInteractorOutputProtocol? { get set }
    var remoteDatamanager: WatchingRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrievePostList(userEntity posts: UserEntity, type: TraktTVAPI.type)
}
