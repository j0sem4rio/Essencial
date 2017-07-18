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
    func showPosts(with posts: [MediaEntity])
    
    func showUpdatePosts()
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol WatchListPresenterProtocol: class {
    var view: WatchListViewProtocol? { get set }
    var interactor: WatchListInteractorInputProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func image(_ posts: [MediaEntity], type: ThemoviedbAPI.typedb)
}

protocol WatchListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrievePosts(_ posts: [MediaEntity])
    func onRetrieveImage()
    func onError()
}

protocol WatchListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: WatchListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostList()
    func retrieveLoadImageList(_ posts: [MediaEntity], type: ThemoviedbAPI.typedb)
}

protocol WatchListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onPostsRetrieved(_ posts: [MediaEntity])
    func onPostsImage()
    func onError()
}

protocol WatchListInteractorInputProtocol: class {
    var presenter: WatchListInteractorOutputProtocol? { get set }
    var remoteDatamanager: WatchListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrievePostList()
    func retrieveUpdatImageList(_ posts: [MediaEntity], type: ThemoviedbAPI.typedb)
}
