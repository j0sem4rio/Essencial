//
//  LeftViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/6/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import PKHUD

enum LeftMenu: String {
    case Main = "HOME"
    case Watching = "WATCHING"
    case Login = "LOGIN"
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController: UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: UserPresenterProtocol?
    
    var menuToReturn = [[String: String]]()
    var mainViewController: UIViewController!
    var loginTrakt: UIViewController!
    var watchingViewController: UIViewController!
    var goViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    var user: UserEntity!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
       
        addChildView("LOGIN", titleOfMenu: NSLocalizedString("login", comment: ""), iconName: "config")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginTrakt = storyboard.instantiateViewController(withIdentifier: "LoginTrakt") as? LoginTrakt
        self.loginTrakt = UINavigationController(rootViewController: loginTrakt!)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
        presenter?.viewDidLoad()
    }
    
    func watchingVC(storyboard: UIStoryboard) -> WatchingCollectionViewController {
        let watching = storyboard.instantiateViewController(withIdentifier: "WatchingCollectionViewController") as? WatchingCollectionViewController
        watching?.user = user
        let presenter: WatchedPresenterProtocol & WatchingInteractorOutputProtocol = WatchingOutputPresenter()
        let interactor: WatchingInteractorInputProtocol & WatchingRemoteDataManagerOutputProtocol = WatchingInteractor()
        let remoteDataManager: WatchingRemoteDataManagerInputProtocol = WatchingRemoteDataManager()
        
        watching?.presenter = presenter
        presenter.view = watching
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return watching!
    }
    func afterLogin() {
        menuToReturn.removeAll()
        addChildView("HOME", titleOfMenu: NSLocalizedString("watchList", comment: ""), iconName: "home")
        addChildView("WATCHING", titleOfMenu: NSLocalizedString("watched", comment: ""), iconName: "config")
        addChildView("LOGIN", titleOfMenu: NSLocalizedString("login", comment: ""), iconName: "config")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let watching = watchingVC(storyboard: storyboard)
        self.watchingViewController = UINavigationController(rootViewController: watching)
        tableView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .Main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .Watching:
            self.slideMenuController()?.changeMainViewController(self.watchingViewController, close: true)
        case .Login:
            self.slideMenuController()?.changeMainViewController(self.loginTrakt, close: true)
        }
    }
    
    func addChildView(_ titleOfChildren: String, titleOfMenu: String, iconName: String) {
        menuToReturn.append(["title": titleOfChildren, "icon": iconName, "name": titleOfMenu])
    }

}

extension LeftViewController: LeftMenuViewProtocol {
    func showPosts(with posts: UserEntity?) {
        if posts != nil {
            self.imageHeaderView.set( forPost: posts! )
            self.user = posts
            
            self.afterLogin()
        }
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: menuToReturn[indexPath.item]["title"]!) {
            switch menu {
            case .Main, .Watching, .Login:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuToReturn.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: menuToReturn[indexPath.row]["title"]!) {
            switch menu {
            case .Main, .Watching, .Login:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menuToReturn[(indexPath as NSIndexPath).row]["name"]!)
                cell.img.image = UIImage(named: menuToReturn[indexPath.row]["icon"]!)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: menuToReturn[indexPath.item]["title"]!) {
            self.changeViewController(menu)
        }
    }
}
extension LeftViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}
