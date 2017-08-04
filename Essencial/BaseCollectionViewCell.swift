//
//  BaseCollectionViewCell.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 8/2/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

@IBDesignable class BaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var highlightView: UIView?
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                highlightView?.isHidden = false
                highlightView?.alpha = 1.0
            } else {
                UIView.animate(withDuration: 0.1,
                               delay: 0.0, options: [.curveEaseOut, .allowUserInteraction],
                               animations: { [unowned self] in
                                self.highlightView?.alpha = 0.0
                }) { _ in
                    self.highlightView?.isHidden = true
                }
            }
        }
    }
    
    var isDark = true {
        didSet {
            guard isDark != oldValue else { return }
            
            titleLabel.textColor =  .white
            titleLabel.layer.shadowColor = isDark ? UIColor.black.cgColor : UIColor.clear.cgColor
        }
    }
    
}
