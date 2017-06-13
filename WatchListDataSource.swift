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
    
    var mediaItems: [MediaEntity] = []
    let cellIdentifier = "CustomerCell"
    
    // MARK: Initializers
    
    override init() {
        super.init()
//        ListMedialItensInteractor(watchListOutputPresenter: self, medialRepository: medialRepositoryStore).list()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text =  mediaItems[indexPath.row].title
        return cell
    }
    
    // MARK: ListCustomersOutputPresenter
    
//    func list(_ mediaItems: [MediaItem]) {
//        self.mediaItems = mediaItems
//    }
}
