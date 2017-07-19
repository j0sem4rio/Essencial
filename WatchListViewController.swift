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

class WatchListViewController: UIViewController, UITableViewDelegate, SFSafariViewControllerDelegate {

    var presenter: WatchListPresenterProtocol?
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var watchListDataSource: WatchListDataSource?
    
    // MARK: UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()  
        presenter?.viewDidLoad(type: .Shows)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: WatchListTableViewCell.identifier)
        let height = (cell?.bounds)!.height
        return height
    }
    
    // MARK: Setups
    
    fileprivate func configureDataSource(mediaItems: [WatchList]) {
        watchListDataSource = WatchListDataSource(mediaItems: mediaItems)
        if let watchListDataSource = watchListDataSource {
            tableView.dataSource = watchListDataSource
        }
    }

}
extension WatchListViewController: WatchListViewProtocol {
    
    func showPosts(with posts: [WatchList]) {
        configureDataSource(mediaItems: posts)
        presenter?.image(posts, type: ThemoviedbAPI.typedb.Tv)
        tableView.reloadData()
    }
    func showUpdatePosts() {
//        configureDataSource(mediaItems: posts)
        tableView.reloadData()
    }
    
    func showError() {
        HUD.flash(.label("Internet not connected"), delay: 2.0)
    }
    
    func showLoading() {
//        HUD.show(.progress)
    }
    
    func hideLoading() {
//        HUD.hide()
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
