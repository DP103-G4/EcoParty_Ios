//
//  UserTableViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/3/2.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    let notUserArrays = ["登入/註冊"]
    let userArrays = ["嗨", "編輯會員資料", "修改密碼", "我的活動", "登出"]
    var userId: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let user = readDemoUser() {
            self.userId = user
        } else {
            userId = 0
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userId != 0 {
            return userArrays.count
            
        } else {
            return notUserArrays.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userId != 0 {
            switch indexPath.row {
            case 0: break
            case 1: break
            case 2: break
            case 3:
                let controller = UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "MyPartyTableViewController") as! MyPartyTableViewController
                self.navigationController?.pushViewController(controller, animated: true)
                
            case 4:
                clearUser()
                self.tabBarController?.selectedIndex = 0
                self.navigationController?.popToRootViewController(animated: true)
            default:
                break
            }
        } else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        if userId != 0 {
            let userArray = userArrays[indexPath.row]
            cell.userOptionLabel.text = userArray
            return cell
        } else {
            let notUserArray = notUserArrays[indexPath.row]
            cell.userOptionLabel.text = notUserArray
            return cell
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
    }
    
    
}
