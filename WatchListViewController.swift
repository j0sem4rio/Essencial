//
//  WatchListViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class WatchListViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var watchListDataSource: WatchListDataSource?
    
    // MARK: UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureDataSource()
        tableView.reloadData()
    }
    
    // MARK: Setups
    
    fileprivate func configureDataSource() {
        watchListDataSource = WatchListDataSource()
        if let watchListDataSource = watchListDataSource {
            tableView.dataSource = watchListDataSource
        }
    }

}
