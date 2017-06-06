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
    
    var mediaItens: [MediaItem]
    
    public init() {
        let mediaItem = MediaEntity(title: "teste")
        self.mediaItens = [mediaItem]
    }
    
    open func all() -> [MediaItem] {
        return mediaItens
    }
    
    open func create(medial: MediaItem) {
        mediaItens.append(medial)
    }
    
}
