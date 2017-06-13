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
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol WatchListPresenterProtocol: class {
    var view: WatchListViewProtocol? { get set }
    var interactor: WatchListInteractorInputProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol WatchListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrievePosts(_ posts: [MediaEntity])
    func onError()
}

protocol WatchListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: WatchListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostList()
}

protocol WatchListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onPostsRetrieved(_ posts: [MediaEntity])
    func onError()
}

protocol WatchListInteractorInputProtocol: class {
    var presenter: WatchListInteractorOutputProtocol? { get set }
    var remoteDatamanager: WatchListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrievePostList()
}
