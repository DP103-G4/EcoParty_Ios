//
//  MyPartyTableViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/3/4.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class MyPartyTableViewController: UITableViewController {
    var myParties = [MyPartyList]()
    var myPieces = [MyPieceList]()
    var userId: Int?
    var requestParam = [String: Any]()
    let url_server = URL(string: common_url + "PartyServlet")
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = readDemoUser() {
            self.userId = user
        } else {
            userId = 0
        }
        showParty()
        showPiece()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if segmentedControl.selectedSegmentIndex == 0 {
            return myParties.count
        } else {
            return myPieces.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPartyTableViewCell", for: indexPath) as! MyPartyTableViewCell
        if segmentedControl.selectedSegmentIndex == 0 {
            let myParty = myParties[indexPath.row]
            
            requestParam["action"] = "getCoverImg"
            requestParam["id"] = myParty.id
            requestParam["imageSize"] = cell.frame.width
            var myPartyImg: UIImage?
            if let url = url_server {
                executeTask(url, requestParam) { (data, response, error) in
                    if error == nil {
                        if data != nil {
                            myPartyImg = UIImage(data: data!)
                        }
                        if myPartyImg == nil {
                            myPartyImg = UIImage(named: "noImage")
                        }
                        DispatchQueue.main.async {
                            cell.myPartyImage.image = myPartyImg
                        }
                    } else {
                        print(error!.localizedDescription)
                    }
                }
            }
        } else {
            let myPiece = myPieces[indexPath.row]
            
            requestParam["action"] = "getCoverImg"
            requestParam["id"] = myPiece.id
            requestParam["imageSize"] = cell.frame.width
            var myPieceImg: UIImage?
            if let url = url_server {
                executeTask(url, requestParam) { (data, response, error) in
                    if error == nil {
                        if data != nil {
                            myPieceImg = UIImage(data: data!)
                        }
                        if myPieceImg == nil {
                            myPieceImg = UIImage(named: "noImage")
                        }
                        DispatchQueue.main.async {
                            cell.myPartyImage.image = myPieceImg
                        }
                    } else {
                        print(error!.localizedDescription)
                    }
                }
            }
        }
        
        // Configure the cell...
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    func showParty() {
        requestParam["action"] = "getMyParty"
        requestParam["userId"] = userId
        if let url = url_server {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        print("input: \(String(data: data!, encoding: .utf8)!)")
                    }
                    if let result = try? JSONDecoder().decode([MyPartyList].self, from: data!) {
                        self.myParties = result
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
    
    func showPiece() {
        requestParam["action"] = "getCurrentParty"
        requestParam["state"] = 4
        requestParam["participantId"] = userId
        if let url = url_server {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        print("input: \(String(data: data!, encoding: .utf8)!)")
                    }
                    if let result = try? JSONDecoder().decode([MyPieceList].self, from: data!) {
                        self.myPieces = result
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
