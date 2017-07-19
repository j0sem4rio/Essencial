//
//  WatchListOutputPresenter.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchListOutputPresenter: WatchListPresenterProtocol {
    weak var view: WatchListViewProtocol?
    var interactor: WatchListInteractorInputProtocol?
    
    func viewDidLoad(type: TraktTVAPI.type) {
        view?.showLoading()
        interactor?.retrievePostList(type: type)
    }
    func image(_ posts: [WatchList], type: ThemoviedbAPI.typedb) {
        interactor?.retrieveUpdatImageList(posts, type: type)
        view?.showUpdatePosts()
    }
}
extension WatchListOutputPresenter: WatchListInteractorOutputProtocol {
    
    func didRetrievePosts(_ posts: [WatchList]) {
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
