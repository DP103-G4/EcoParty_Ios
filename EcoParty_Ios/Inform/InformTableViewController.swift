//
//  InformTableViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/21.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit
class InformTableViewController: UITableViewController {
    var informs = [Inform]()
    var userId: Int?
    let url_server = URL(string: common_url + "InformServlet")
    var requestParam = [String: Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = readDemoUser() {
            self.userId = user
        } 
        showInforms()
    }
    func showInforms() {
        requestParam["action"] = "getAllInform"
        requestParam["receiverId"] = userId
        let decoder = JSONDecoder()
        let format = DateFormatter()
        format.dateFormat = "yyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(format)
        if let url = url_server {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        print("input: \(String(data: data!, encoding: .utf8)!)")
                    }
                    if let result = try? decoder.decode([Inform].self, from: data!) {
                        self.informs = result
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return informs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InformTableViewCell", for: indexPath) as! InformTableViewCell
        let inform = informs[indexPath.row]
        cell.informTitleLabel.text = "活動通知"
        cell.informContentLabel.text = inform.content
        if inform.isRead == true {
            cell.backgroundColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor(red: 255, green: 253, blue: 224, alpha: 0.5)
        }
        return cell
    }
    
    @IBAction func setAllRead(_ sender: Any) {
        requestParam["action"] = "setRead"
        requestParam["receiverId"] = userId
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    if let result = String(data: data!, encoding: .utf8) {
                        if let count = Int(result) {
                            if count != 0 {
                                DispatchQueue.main.async {
                                    for i in 0...self.informs.count - 1 {
                                        self.informs[i].isRead = true
                                    }
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}
