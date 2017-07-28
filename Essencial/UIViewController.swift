//
//  UIViewController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/6/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "D69F83")
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "D69F83")
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
    }
    
    public func slideMenuController() -> SlideMenuController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is SlideMenuController {
                return viewController as? SlideMenuController
            }
            viewController = viewController?.parent
        }
        return nil
    }
    
    public func addLeftBarButtonWithImage(_ buttonImage: UIImage) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.toggleLeft))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    public func addRightBarButtonWithImage(_ buttonImage: UIImage) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.toggleRight))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    public func toggleLeft() {
        slideMenuController()?.toggleLeft()
    }
    
    public func toggleRight() {
        slideMenuController()?.toggleRight()
    }
    
    public func openLeft() {
        slideMenuController()?.openLeft()
    }
    
    public func openRight() {
        slideMenuController()?.openRight()
    }
    
    public func closeLeft() {
        slideMenuController()?.closeLeft()
    }
    
    public func closeRight() {
        slideMenuController()?.closeRight()
    }
    
    // Please specify if you want menu gesuture give priority to than targetScrollView
    public func addPriorityToMenuGesuture(_ targetScrollView: UIScrollView) {
        guard let slideController = slideMenuController(), let recognizers = slideController.view.gestureRecognizers else {
            return
        }
        for recognizer in recognizers where recognizer is UIPanGestureRecognizer {
            targetScrollView.panGestureRecognizer.require(toFail: recognizer)
        }
    }
    
    func fixIOS9PopOverAnchor(_ segue: UIStoryboardSegue?) {
        if let popOver = segue?.destination.popoverPresentationController,
            let anchor  = popOver.sourceView, popOver.sourceRect == CGRect()
            && segue!.source === self {
            popOver.sourceRect = anchor.bounds
        }
    }
    func fixPopOverAnchor(_ controller: UIAlertController) {
        if let popOver = controller.popoverPresentationController,
            let anchor = popOver.sourceView, popOver.sourceRect == CGRect() {
            popOver.sourceRect = anchor.bounds }
    }
    
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return Swift.min(statusBarSize.width, statusBarSize.height)
    }
    
    func dismissUntilAnimated<T: UIViewController>(_ animated: Bool, viewController: T.Type, completion: ((_ viewController: T) -> Void)?) {
        var vc = presentingViewController!
        while let new = vc.presentingViewController, !(new is T) {
            vc = new
        }
        vc.dismiss(animated: animated, completion: {
            completion?((vc as? T)!)
        })
    }
    
}
