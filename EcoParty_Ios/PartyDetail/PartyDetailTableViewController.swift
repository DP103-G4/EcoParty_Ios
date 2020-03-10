//
//  PartyDetailTableViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/3/8.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class PartyDetailTableViewController: UITableViewController, UITextFieldDelegate {
    var partyList: PartyList?
    var partyDetails = [PartyInfo]()
    var userId: Int?
    var requestParam = [String: Any]()
    let url_server = URL(string: common_url + "PartyServlet")
    
    
    @IBOutlet weak var inputTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        inputTextField.delegate = self
        navigationItem.title = "活動詳情"
        createTapGesture()
        showPartyDetails()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = readDemoUser() {
            self.userId = user
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func createTapGesture() {
        let tapHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapHideKeyboard.cancelsTouchesInView = false
        view.addGestureRecognizer(tapHideKeyboard)
    }
    
    @objc func hideKeyboard() {
        navigationController?.view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartyDetailTableViewCell", for: indexPath) as! PartyDetailTableViewCell
        let partyDetail: PartyInfo
        cell.userImageView.image = UIImage(named: "woman")
        cell.userNameLabel.text = "小明"
        cell.userMsgLabel.text = "testtesttesttes"
        cell.msgTimeLabel.text = "2020/3/8"
        
        return cell
    }
    
    func showPartyDetails() {
        requestParam["action"] = "getParty"
        requestParam["id"] = partyList?.id
        requestParam["userId"] = userId
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
                    if let result = try? decoder.decode([PartyInfo].self, from: data!) {
                        self.partyDetails = result
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
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        
    }
}

extension PartyDetailTableViewController: PartyCollectionViewControllerDelegate {
    func loadParty(data: PartyList?) {
        let controller = UIStoryboard(name: "PartyDetail", bundle: nil).instantiateViewController(identifier: "PartyDetailTableViewController") as! PartyDetailTableViewController
        controller.partyList = data
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
