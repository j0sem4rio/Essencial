//
//  WatchListTableViewCell.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/14/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import AlamofireImage

class WatchListTableViewCell: UITableViewCell {

    class var identifier: String { return String.className(self) }
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    func set(forPost post: MediaEntity) {
        self.selectionStyle = .none
        titleLabel?.text = post.title
        yearLabel?.text = String(post.year)
        if post.imageUrl != nil {
            let url = URL(string: post.imageUrl!)!
            let placeholderImage = UIImage(named: "placeholder")!
            postImageView?.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
    }
    
}
