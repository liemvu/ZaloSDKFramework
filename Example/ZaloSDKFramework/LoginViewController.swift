//
//  ViewController.swift
//  ZaloSDKFramework
//
//  Created by acct<blob>=<NULL> on 09/26/2017.
//  Copyright (c) 2017 acct<blob>=<NULL>. All rights reserved.
//

import UIKit
import ZaloSDKFramework

class LoginViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.alignButtonIconAndTitle()
        checkIsAuthenticated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func loginButtonDidTouch(_ sender: Any) {
        login()
    }

    func showMainController() {
        self.performSegue(withIdentifier: "showMainController", sender: self)
    }
}

extension LoginViewController {
    func login() {
        ZaloSDKFramework.sharedInstance.authenticate(from: self) { (response) in
            self.onAuthenticateComplete(with: response)
        }
    }
    
    func checkIsAuthenticated() {
        loadingIndicator.startAnimating()
        loginButton.isHidden = true
        
        ZaloSDKFramework.sharedInstance.isAuthenticated { (response) in
            self.loadingIndicator.stopAnimating()
            if response.isSucess {
                self.showMainController()
            } else {
                self.loginButton.isHidden = false
            }
        }
    }
    
    func onAuthenticateComplete(with response: AuthenResponse) {
        loadingIndicator.stopAnimating()
        loginButton.isHidden = false
        if response.isSucess {
            showMainController()
        } else if response.errorCode != -1001 { // not cancel
            showAlert(with: "Error \(response.errorCode)", message: response.errorMessage)
        }
    }
}

extension UIViewController {
    func showAlert(with title: String = "ZaloSDK", message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            controller.dismiss(animated: true, completion: nil)
        }
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }
}

extension UIButton {
    func alignButtonIconAndTitle() {
        guard let imageView = self.imageView,
            let titleLabel = self.titleLabel else {
            return
        }
        self.contentHorizontalAlignment = .left
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let space = UIEdgeInsetsInsetRect(self.bounds, self.contentEdgeInsets)
        let width = space.width - self.imageEdgeInsets.right - imageView.frame.size.width - titleLabel.frame.size.width
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: width/2, bottom: 0, right: 0)
    }
}
