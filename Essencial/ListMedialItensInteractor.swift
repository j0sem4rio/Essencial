//
//  ListMedialItensInteractor.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit


public struct ListMedialItensInteractor {
    
    var watchListOutputPresenter: WatchListOutputPresenter
    var medialRepository: MedialRepository
    
    public init(watchListOutputPresenter: WatchListOutputPresenter, medialRepository: MedialRepository) {
        self.watchListOutputPresenter = watchListOutputPresenter
        self.medialRepository = medialRepository
    }
    
    public func list() {
        let medialItens = medialRepository.all()
        watchListOutputPresenter.list(medialItens)
    }
    
}
