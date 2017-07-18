//
//  WatchingCollectionViewCell.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 7/13/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchingCollectionViewCell: UICollectionViewCell {
    class var identifier: String { return String.className(self) }
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var watchedIndicator: UIView?
    var watched: Bool = false {
        didSet {
            if let watchedIndicator = watchedIndicator {
                UIView.animate(withDuration: 0.25, animations: {
                    if self.watched {
                        watchedIndicator.alpha = 0.5
                        watchedIndicator.isHidden = false
                    } else {
                        watchedIndicator.alpha = 0.0
                        watchedIndicator.isHidden = true
                    }
                })
            }
        }
    }
    
}