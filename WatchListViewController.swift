//
//  WatchListViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import SafariServices
import PKHUD

class WatchListViewController: UIViewController, SFSafariViewControllerDelegate {

    var presenter: WatchListPresenterProtocol?
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var watchListDataSource: WatchListDataSource?
    
    // MARK: UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()  
        presenter?.viewDidLoad()
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: Setups
    
    fileprivate func configureDataSource(mediaItems: [MediaEntity]) {
        watchListDataSource = WatchListDataSource(mediaItems: mediaItems)
        if let watchListDataSource = watchListDataSource {
            tableView.dataSource = watchListDataSource
        }
    }

}
extension WatchListViewController: WatchListViewProtocol {
    
    func showPosts(with posts: [MediaEntity]) {
        configureDataSource(mediaItems: posts)
        tableView.reloadData()
    }
    
    func showError() {
        HUD.flash(.label("Internet not connected"), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
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
