//
//  NewsViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/28.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit



class NewsViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let url_server = URL(string: common_url + "NewsServlet")
    var news : News?
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        return
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailTableViewCell", for: indexPath) as! NewsDetailTableViewCell
        var requestParam = [String: Any]()
        requestParam["action"] = "getImage"
        requestParam["id"] = news?.id
        requestParam["imageSize"] = view.frame.width
        
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
                        cell.newsImageView.image = image
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
        cell.newsTitleLabel.text = news?.title
        cell.newsPostLabel.text = news?.dateStr
        cell.newsContentTextView.text = news?.content
        
        return cell
    }
}


