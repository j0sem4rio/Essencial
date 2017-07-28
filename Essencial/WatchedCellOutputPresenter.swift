//
//  WatchedCellOutputPresenter.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/26/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchedCellOutputPresenter: WatchedCellPresenterProtocol {
    weak var cell: WatchedCellProtocol?
    var interactor: WatchedCellInteractorInputProtocol?

        func image(_ posts: Watched, type: ThemoviedbAPI.typedb) {
            interactor?.retrieveUpdatImageList(posts, type: type)
        }
}
extension WatchedCellOutputPresenter: WatchedCellInteractorOutputProtocol {
    func didRetrievePosts(_ posts: Watched) {
        cell?.showUpdatePosts(posts)
    }
    
    func didRetrievePosts(_ posts: [Watched]) {
        
    }
    func onError() {
        
    }
}
