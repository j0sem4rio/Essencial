//
//  LoginTrakt.swift
//  Essencial
//
//  Created by Jose Mario Fernandes on 6/8/17.
//  Copyright © 2017 Jose Mario Fernandes. All rights reserved.
//

import UIKit
import SafariServices
import SkyFloatingLabelTextField
import RxSwift
import RxCocoa

class LoginTrakt: UIViewController, SFSafariViewControllerDelegate {

    var disposeBag = DisposeBag()
    @IBOutlet weak var pinField: SkyFloatingLabelTextField!
    @IBOutlet weak var submit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let safariViewController = SFSafariViewController(url: TraktTVAPI().authorizationURL!)
        present(safariViewController, animated: true, completion: nil)
        safariViewController.delegate = self
        
        let usernameValid = pinField!.rx.textInput.text
            .map { ($0?.characters.count)! >= 1 }
            .shareReplay(1)
        let everythingValid = Observable.asObservable(usernameValid)() 
            .shareReplay(1)
        
        everythingValid
            .bind(to: submit.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }
    
    @IBAction func submitPin(_ sender: UIButton) {
        TraktTVAPI().getToken(pin:  pinField.text!) { (value) in
            if value {
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

}
