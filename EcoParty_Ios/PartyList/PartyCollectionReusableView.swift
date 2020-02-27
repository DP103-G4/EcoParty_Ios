//
//  PartyCollectionReusableView.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/27.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class PartyCollectionReusableView: UICollectionReusableView, UICollectionViewDataSource, UICollectionViewDelegate {
    var news = [News]()
    let url_server = URL(string: common_url + "NewsServlet")
    var requestParam = [String: Any]()
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var partyHeaderCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var partyHeaderCollection: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let width = partyHeaderCollection.bounds.width - 1 * 2
        let layout = partyHeaderCollectionViewFlowLayout
        layout?.itemSize = CGSize(width: width, height: width)
        layout?.estimatedItemSize = .zero
        getNews()
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = partyHeaderCollection.dequeueReusableCell(withReuseIdentifier: "newsBannerCell", for: indexPath) as! NewsBannerCollectionViewCell
        let newsImage = news[indexPath.item]
        requestParam["action"] = "getImage"
        requestParam["id"] = newsImage.id
        requestParam["imageSize"] = cell.frame.width
        var newsImg: UIImage?
        if let url = url_server {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        newsImg = UIImage(data: data!)
                    }
                    if newsImg == nil {
                        newsImg = UIImage(named: "noImage")
                    }
                    DispatchQueue.main.async {
                        cell.newsImageView.image = newsImg
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
        
        //        cell.newsImageView.image = UIImage(named: "banner3")
        image.image = UIImage(named: "banner1")
        return cell
    }
    
    func getNews() {
        requestParam["action"] = "getAllNews"
        if let url = url_server {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        print("input: \(String(data: data!, encoding: .utf8)!)")
                        if let result = try? JSONDecoder().decode([News].self, from: data!) {
                            self.news = result
                            DispatchQueue.main.async {
                                self.partyHeaderCollection.reloadData()
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
