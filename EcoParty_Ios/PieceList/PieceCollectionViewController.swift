//
//  PieceCollectionViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/18.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PieceCollectionViewCell"

class PieceCollectionViewController: UICollectionViewController {
    var pieceLists = [PieceList]()
    var userId: Int?
    let url_server = URL(string: common_url + "PartyServlet")
    var requestParam = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (collectionView.bounds.width - 1 * 2) / 2
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: width, height: width)
        layout?.estimatedItemSize = .zero
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = readDemoUser() {
            self.userId = user
        } 
        showPieceList()
    }
    
    func showPieceList() {
        requestParam["action"] = "getPieceList"
        requestParam["state"] = 4
        if let url = url_server {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        print("input: \(String(data: data!, encoding: .utf8)!)")
                        if let result = try? JSONDecoder().decode([PieceList].self, from: data!) {
                            self.pieceLists = result
                            print("abc: \(result)")
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pieceLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PieceCollectionViewCell
        let party = pieceLists[indexPath.item]
        print("123 \(party)")
        requestParam["action"] = "getAfterImg"
        requestParam["id"] = party.id
        
        //    圖片寬度為tableViewCell的1/4，ImageView的寬度也建議在storyboard加上比例設定的constraint
        requestParam["imageSize"] = cell.frame.width * 2
        var image: UIImage?
        
        if let url = url_server {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        image = UIImage(data: data!)
                        
                    }
                    if image == nil {
                        image = UIImage(named: "noImage")
                    }
                    DispatchQueue.main.async {
                        cell.pieceImage.image = image
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
        return cell
    }
}
