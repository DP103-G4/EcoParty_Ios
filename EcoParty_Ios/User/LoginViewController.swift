//
//  LoginViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/3/2.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var users = [User]()
    var requestParam = [String: Any]()
    let url_server = URL(string: common_url + "UserServlet")
    
    @IBOutlet weak var inputErrorLabel: UILabel!
    @IBOutlet weak var userPasswordLabel: UITextField!
    @IBOutlet weak var userAccountLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func demoLogin(_ sender: Any) {
        let id = 20
        
        saveDemoUser(id: id)
        
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @IBAction func login(_ sender: Any) {
        let userName = userAccountLabel.text == nil ? "" : userAccountLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = userPasswordLabel.text == nil ? "" : userPasswordLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if userName!.isEmpty || password!.isEmpty {
            inputErrorLabel.isHidden = false
            return
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
    }
}
