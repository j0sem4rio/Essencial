//
//  LeftViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/6/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

enum LeftMenu: String {
    case Main = "HOME"
//    case Swift = "CONTACT"
//    case Java = "LOVE"
//    case Go = "SETTINGS"
//    case NonMenu = "NonMenu"
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController: UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menuToReturn = [[String: String]]()
    var mainViewController: UIViewController!
    var swiftViewController: UIViewController!
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
        addChildView("ContactScreenID", titleOfChildren: "CONTACT", iconName: "contact")
        addChildView("LoveScreenID", titleOfChildren: "LOVE", iconName: "love")
        addChildView("SettingsScreenID", titleOfChildren: "SETTINGS", iconName: "settings")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "SwiftViewController") as! SwiftViewController
//        self.swiftViewController = UINavigationController(rootViewController: swiftViewController)
//        
//        let javaViewController = storyboard.instantiateViewController(withIdentifier: "JavaViewController") as! JavaViewController
//        self.javaViewController = UINavigationController(rootViewController: javaViewController)
//        
//        let goViewController = storyboard.instantiateViewController(withIdentifier: "GoViewController") as! GoViewController
//        self.goViewController = UINavigationController(rootViewController: goViewController)
//        
//        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
//        nonMenuController.delegate = self
//        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.imageHeaderView.profileImage.image = UIImage(named: "icon")
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .Main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
//        case .Swift:
//            self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
//        case .Java:
//            self.slideMenuController()?.changeMainViewController(self.javaViewController, close: true)
//        case .Go:
//            self.slideMenuController()?.changeMainViewController(self.goViewController, close: true)
//        case .NonMenu:
//            self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        }
    }
    
    func addChildView(_ storyBoardID: String, titleOfChildren: String, iconName: String) {
        menuToReturn.append(["title": titleOfChildren, "icon": iconName])
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: menuToReturn[indexPath.item]["title"]!) {
            switch menu {
            case .Main:
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
            case .Main:
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
