//
//  WatchListViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import SafariServices

class WatchListViewController: UIViewController, SFSafariViewControllerDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var watchListDataSource: WatchListDataSource?
    
    // MARK: UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let safariViewController = SFSafariViewController(url: TraktTVAPI().authorizationURL!)
//        present(safariViewController, animated: true, completion: nil)
//        safariViewController.delegate = self       
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
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
extension WatchListViewController: SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
