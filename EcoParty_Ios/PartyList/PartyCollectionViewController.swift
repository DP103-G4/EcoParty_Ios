//
//  PartyCollectionViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/21.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PartyCollectionViewCell"

class PartyCollectionViewController: UICollectionViewController {
    
    var partyLists = [PartyList]()
    let url_server = URL(string: common_url + "PartyServlet")
    var requestParam = [String: Any]()
    var imageArray = [String]()
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //                titleView的元件換成searchBar
        let searchBar = UISearchBar()
        searchBar.placeholder = "請輸入活動名稱"
        navigationItem.titleView = searchBar
        let width = (collectionView.bounds.width - 5 * 2) / 2
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: width, height: width + 55)
        layout?.estimatedItemSize = .zero
        
        collectionView.addSubview(refresh)
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: true)
        showPartyList()
        
        
        //        設定tab小圓點
        //        if let tabItems = tabBarController?.tabBar.items {
        //            let tabItem = tabItems[2]
        //            tabItem.badgeValue = "1"
        //        }
    }
    
    func loadData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.refresh.addTarget(self, action: #selector(self.showPartyList), for: .valueChanged)
            
            
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return partyLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PartyCollectionViewCell
        let partyList = partyLists[indexPath.item]
        requestParam["action"] = "getCoverImg"
        requestParam["id"] = partyList.id
        requestParam["imageSize"] = cell.frame.width
        var partyImg: UIImage?
        if let url = url_server {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        partyImg = UIImage(data: data!)
                    }
                    if partyImg == nil {
                        partyImg = UIImage(named: "noImage")
                    }
                    DispatchQueue.main.async {
                        cell.partyImage.image = partyImg
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
        let userUrl = URL(string: common_url + "UserServlet")
        requestParam["action"] = "getImage"
        requestParam["id"] = partyList.ownerId
        requestParam["imageSize"] = cell.frame.width / 20
        var ownerImg: UIImage?
        if let userUrl = userUrl {
            executeTask(userUrl, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        ownerImg = UIImage(data: data!)
                    }
                    if ownerImg == nil {
                        ownerImg = UIImage(named: "noImage")
                    }
                    DispatchQueue.main.async {
                        cell.partyOwnerImage.image = ownerImg
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
        let format = DateFormatter()
        // 設定地區(台灣)
        format.locale = Locale(identifier: "zh_Hant_TW")
        // 設定時區(台灣)
        //        format.timeZone = TimeZone(identifier: "Asia/Taipei")
        format.dateFormat = "E M月d日"
        cell.partyNameLabel.text = partyList.name
        cell.partyAddressLabel.text = partyList.address
        cell.partyStartLabel.text = format.string(from: partyList.startTime)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PartyCollectionViewHeader", for: indexPath) 
        
        return headerView
    }
    
    @objc func showPartyList() {
        self.refresh.endRefreshing()
        requestParam["action"] = "getPartyList"
        requestParam["state"] = 1
        let decoder = JSONDecoder()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(format)
        if let url = url_server {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        print("input: \(String(data: data!, encoding: .utf8)!)")
                        if let result = try? decoder.decode([PartyList].self, from: data!) {
                            self.partyLists = result
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
    }
}
