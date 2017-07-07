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
    var javaViewController: UIViewController!
    var goViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        addChildView("HomeScreenID", titleOfChildren: "HOME", iconName: "home")
        addChildView("ContactScreenID", titleOfChildren: "LOGIN", iconName: "config")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginTrakt = storyboard.instantiateViewController(withIdentifier: "LoginTrakt") as? LoginTrakt
        self.loginTrakt = UINavigationController(rootViewController: loginTrakt!)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
        presenter?.viewDidLoad()
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
        case .Login:
            self.slideMenuController()?.changeMainViewController(self.loginTrakt, close: true)
        }
    }
    
    func addChildView(_ storyBoardID: String, titleOfChildren: String, iconName: String) {
        menuToReturn.append(["title": titleOfChildren, "icon": iconName])
    }

}

extension LeftViewController: LeftMenuViewProtocol {
    func showPosts(with posts: UserEntity) {
        self.imageHeaderView.set( forPost: posts )
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
            case .Main, .Login:
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
            case .Main, .Login:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menuToReturn[indexPath.row]["title"]!)
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
