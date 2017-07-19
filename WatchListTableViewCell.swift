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
    
    func set(forPost post: WatchList) {
        self.selectionStyle = .none
        if let show = post.show {
            titleLabel?.text = show.title
            yearLabel?.text = String(show.year)
            if show.imageUrl != nil {
                let url = URL(string: show.imageUrl!)!
                let placeholderImage = UIImage(named: "placeholder")!
                postImageView?.af_setImage(withURL: url, placeholderImage: placeholderImage)
            }
        } else {
            titleLabel?.text = post.movie.title
            yearLabel?.text = String(post.movie.year)
            if post.movie.imageUrl != nil {
                let url = URL(string: post.movie.imageUrl!)!
                let placeholderImage = UIImage(named: "placeholder")!
                postImageView?.af_setImage(withURL: url, placeholderImage: placeholderImage)
            }
        }
        
    }
    
}
