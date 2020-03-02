//
//  NewsViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/28.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit



class NewsViewController: UIViewController, UIScrollViewDelegate {
    let url_server = URL(string: common_url + "NewsServlet")
    var news : News?
    

    @IBOutlet weak var newsContentTextView: UITextView!
    @IBOutlet weak var newsPostLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        newsTitleLabel.text = news?.title
        newsContentTextView.text = news?.content
        newsPostLabel.text = news?.dateStr
        getNewsImage()

    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        return
    }
    
    func getNewsImage() {
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
                        self.newsImageView.image = image
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
    }
    
}


