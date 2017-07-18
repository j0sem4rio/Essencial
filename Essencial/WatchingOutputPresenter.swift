//
//  WatchingOutputPresenter.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchingOutputPresenter: WatchingPresenterProtocol {
    weak var view: WatchingViewProtocol?
    var interactor: WatchingInteractorInputProtocol?
    
    func viewDidLoad(userEntity posts: UserEntity, type: TraktTVAPI.type) {
        view?.showLoading()
        interactor?.retrievePostList(userEntity: posts, type: type)
    }
    func image(_ posts: [Watched]) {
        interactor?.retrieveUpdatImageList(posts)
        view?.showUpdatePosts()
    }
}
extension WatchingOutputPresenter: WatchingInteractorOutputProtocol {
    
    func didRetrievePosts(_ posts: [Watched]) {
        view?.hideLoading()
        view?.showPosts(with: posts)
    }
    func onRetrieveImage() {
        view?.showUpdatePosts()
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}
