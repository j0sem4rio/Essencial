//
//  WatchListViewProtocol.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

protocol WatchListViewProtocol: class {
    var presenter: WatchListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showPosts(with posts: [WatchList])
    
    func showUpdatePosts()
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol WatchListPresenterProtocol: class {
    var view: WatchListViewProtocol? { get set }
    var interactor: WatchListInteractorInputProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad(type: TraktTVAPI.type)
    func image(_ posts: [WatchList], type: ThemoviedbAPI.typedb)
}

protocol WatchListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrievePosts(_ posts: [WatchList])
    func onRetrieveImage()
    func onError()
}

protocol WatchListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: WatchListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostList(type: TraktTVAPI.type)
    func retrieveLoadImageList(_ posts: [WatchList], type: ThemoviedbAPI.typedb)
}

protocol WatchListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onPostsRetrieved(_ posts: [WatchList])
    func onPostsImage()
    func onError()
}

protocol WatchListInteractorInputProtocol: class {
    var presenter: WatchListInteractorOutputProtocol? { get set }
    var remoteDatamanager: WatchListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrievePostList(type: TraktTVAPI.type)
    func retrieveUpdatImageList(_ posts: [WatchList], type: ThemoviedbAPI.typedb)
}
