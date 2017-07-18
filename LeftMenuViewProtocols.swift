//
//  LeftMenuViewProtocols.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

protocol LeftMenuViewProtocol: class {
    var presenter: UserPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showPosts(with posts: UserEntity?)
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol UserPresenterProtocol: class {
    var view: LeftMenuViewProtocol? { get set }
    var interactor: UserInteractorInputProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol UserInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrievePosts(_ posts: UserEntity?)
    func onError()
}

protocol UserRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: UserRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostUser()
}

protocol UserRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onPostsRetrieved(_ posts: UserEntity?)
    func onError()
}

protocol UserInteractorInputProtocol: class {
    var presenter: UserInteractorOutputProtocol? { get set }
    var remoteDatamanager: UserRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrievePostUser()
}
