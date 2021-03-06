//
//  ExSlideMenuController.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/6/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit

class ExSlideMenuController: SlideMenuController {
    
    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is WatchListViewController ||
                vc is LoginTrakt {
                return true
            }
        }
        return false
    }
    
    override func track(_ trackAction: TrackAction) {
        switch trackAction {
        case .leftTapOpen:
            print("TrackAction: left tap open.")
        case .leftTapClose:
            print("TrackAction: left tap close.")
        case .leftFlickOpen:
            print("TrackAction: left flick open.")
        case .leftFlickClose:
            print("TrackAction: left flick close.")        
        }
    }
}
