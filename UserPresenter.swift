//
//  UserPresenter.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

class UserPresenter: UserPresenterProtocol {
    weak var view: LeftMenuViewProtocol?
    var interactor: UserInteractorInputProtocol?
    
    func viewDidLoad() {
        
        interactor?.retrievePostUser()
    }
}
extension UserPresenter: UserInteractorOutputProtocol {
    
    func didRetrievePosts(_ posts: UserEntity) {
//        view?.hideLoading()
        view?.showPosts(with: posts)
    }
    
    func onError() {
//        view?.hideLoading()
        view?.showError()
    }
    
}
