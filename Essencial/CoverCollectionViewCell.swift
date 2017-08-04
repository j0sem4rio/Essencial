//
//  CoverCollectionViewCell.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 8/3/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class CoverCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet var watchedIndicator: UIImageView?
    
    var watched = false {
        didSet {
            watchedIndicator?.isHidden = !watched
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [highlightView, imageView].forEach {
            $0?.layer.cornerRadius = self.bounds.width * 0.02
            $0?.layer.masksToBounds = true
        }
    }
}
