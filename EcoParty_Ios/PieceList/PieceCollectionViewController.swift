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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pieceLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PieceCollectionViewCell
        let party = pieceLists[indexPath.item]
        print("123 \(party)")
        requestParam["action"] = "getAfterImg"
        requestParam["id"] = party.id
        
        //    圖片寬度為tableViewCell的1/4，ImageView的寬度也建議在storyboard加上比例設定的constraint
        requestParam["imageSize"] = cell.frame.width
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
    
}
