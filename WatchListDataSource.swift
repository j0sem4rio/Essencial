//
//  WatchListDataSource.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchListDataSource: NSObject, UITableViewDataSource {
    
    // MARK: Properties
    
    var mediaItems: [WatchList] = []
    let cellIdentifier = "CustomerCell"
    
    // MARK: Initializers
    
    init(mediaItems: [WatchList]) {
        self.mediaItems = mediaItems
        super.init()
    }
    
    // MARK: UITableViewDataSource      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WatchListTableViewCell.identifier, for: indexPath) as? WatchListTableViewCell
        
        let post = mediaItems[indexPath.row]
        cell?.set(forPost: post)
        
        return cell!
    }
}
