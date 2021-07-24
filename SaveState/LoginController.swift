//
//  LoginController.swift
//  SaveState
//
//  Created by LanceMacBookPro on 7/24/21.
//

import UIKit

class LoginController: UIViewController {
    
    
    
    // MARK: - UIElements
    fileprivate lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemIndigo
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "Log In"
        
        registerUserDefaults()
        
        configureAnchors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        
        if loggedIn {
            
            let vc = ViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Target Actions
    @objc fileprivate func loginButtonPressed() {
        
        UserDefaults.standard.set(true, forKey: "loggedIn")
        
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helper Functions
    fileprivate func registerUserDefaults() {
        
        let alreadyRegistered = UserDefaults.standard.bool(forKey: "alreadyRegistered")
        
        if !alreadyRegistered {
            
            var dict = [String:Any]()
            dict.updateValue(false, forKey: "loggedIn")
            
            UserDefaults.standard.register(defaults: dict)
        }
    }
    
    // MARK: - Anchors
    fileprivate func configureAnchors() {
        
        view.addSubview(loginButton)
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}
