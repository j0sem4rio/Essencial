//
//  AppDelegate.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 05/06/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

let medialRepositoryStore = MedialRepositoryStore()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    fileprivate func createMenuView() {

        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let watchListViewController = storyboard.instantiateViewController(withIdentifier: "WatchListViewController") as? WatchListViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as? LeftViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: watchListViewController!)
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "ffffff")//cores dos icones
        
        leftViewController?.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController!)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = watchListViewController
        slideMenuController.changeLeftViewWidth((leftViewController?.mainViewController.view.frame.width)! * 0.8 )
        
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.createMenuView()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        guard let query = url.query else { return false }
        guard let code = query.components(separatedBy: "=").last else { return false }
        print(code)
        
        return true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let urlString = url.absoluteString
        print(urlString)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
