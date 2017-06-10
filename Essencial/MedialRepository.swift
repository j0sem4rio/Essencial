//
//  MedialRepository.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

public protocol MedialRepository {
    func all() -> [MediaItem]
    func create(medial: MediaItem)
}

open class MedialRepositoryStore: MedialRepository {
    
    var mediaItens: [MediaItem] = []    

    open func all() -> [MediaItem] {
//        TraktTVAPI().scrobble(id: "tt0372784", progress: 0, type: .Movies, status: .Watching) { (medias) in
//            self.mediaItens = medias
//        }
        TraktTVAPI().getList { (medias) in
            self.mediaItens = medias
        }
        return mediaItens
    }
    
    open func create(medial: MediaItem) {
        mediaItens.append(medial)
    }
    
}
