//
//  PartyCollectionReusableView.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/27.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit
protocol PartyCollectionReusableViewDelegate {
    func didSelectItemWithData(data: News?)
}
class PartyCollectionReusableView: UICollectionReusableView, UICollectionViewDataSource, UICollectionViewDelegate {
    var news = [News]()
    var currentParties = [CurrentPartyList]()
    var delegate: PartyCollectionReusableViewDelegate?
    
    let newsUrl = URL(string: common_url + "NewsServlet")
    let currentPartyUrl = URL(string: common_url + "PartyServlet")
    var requestParam = [String: Any]()
    
    @IBOutlet weak var currentPartyCollectionView: UICollectionView!
    
    @IBOutlet weak var currentPartyCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var partyHeaderCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var partyHeaderCollection: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == partyHeaderCollection {
            let selectCell = collectionView.cellForItem(at: indexPath) as! NewsBannerCollectionViewCell
            let senderData = selectCell.newsData
            self.delegate?.didSelectItemWithData(data: senderData)
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == partyHeaderCollection {
            let width = partyHeaderCollection.bounds.width - 5
            let layout = partyHeaderCollectionViewFlowLayout
            layout?.itemSize = CGSize(width: width, height: width)
            layout?.estimatedItemSize = .zero
            return news.count
        } else {
            let width = currentPartyCollectionView.bounds.width - 5
            let layout = currentPartyCollectionViewFlowLayout
            layout?.itemSize = CGSize(width: width, height: width)
            layout?.estimatedItemSize = .zero
            return currentParties.count
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == partyHeaderCollection {
            let cell = partyHeaderCollection.dequeueReusableCell(withReuseIdentifier: "newsBannerCell", for: indexPath) as! NewsBannerCollectionViewCell
            let newsImage = news[indexPath.item]
            requestParam["action"] = "getImage"
            requestParam["id"] = newsImage.id
            requestParam["imageSize"] = cell.frame.width
            var newsImg: UIImage?
            if let url = newsUrl {
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
            //        image.image = UIImage(named: "banner1")
            cell.newsData = self.news[indexPath.item]
            print("aaa")
            return cell
        } else {
            let cell = currentPartyCollectionView.dequeueReusableCell(withReuseIdentifier: "CurrentPartyCollectionViewCell", for: indexPath) as! CurrentPartyCollectionViewCell
            let currentPartyImage = currentParties[indexPath.item]
            requestParam["action"] = "getCoverImg"
            requestParam["id"] = currentPartyImage.id
            requestParam["imageSize"] = cell.frame.width
            var currentPartyImg: UIImage?
            if let url = currentPartyUrl {
                executeTask(url, requestParam) { (data, response, error) in
                    if error == nil {
                        if data != nil {
                            currentPartyImg = UIImage(data: data!)
                        }
                        if currentPartyImg == nil {
                            currentPartyImg = UIImage(named: "noImage")
                        }
                        DispatchQueue.main.async {
                            cell.currentPartyImage.image = currentPartyImg
                        }
                    } else {
                        print(error!.localizedDescription)
                    }
                }
            }
            print("bbb")
            return cell
        }
        
    }
    
    func getCurrentParty() {
        requestParam["action"] = "getCurrentParty"
        requestParam["state"] = 3
        requestParam["participantId"] = 2
        if let url = currentPartyUrl {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        print("input: \(String(data: data!, encoding: .utf8)!)")
                        if let result = try? JSONDecoder().decode([CurrentPartyList].self, from: data!) {
                            self.currentParties = result
                            DispatchQueue.main.async {
                                self.currentPartyCollectionView.reloadData()
                            }
                        }
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
    }
    
    func getNews() {
        requestParam["action"] = "getAllNews"
        let decoder = JSONDecoder()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(format)
        if let url = newsUrl {
            executeTask(url, requestParam) { (data, response, error) in
                if error == nil {
                    if data != nil {
                        print("input: \(String(data: data!, encoding: .utf8)!)")
                        if let result = try? decoder.decode([News].self, from: data!) {
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
