//
//  NewsBannerCollectionView.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/26.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

class NewsBannerCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let width = (collectionView.bounds.width - 5 * 2) / 2
        let layout =  collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: width, height: width + 55)
        layout?.estimatedItemSize = .zero
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsBannerCell", for: indexPath) as! NewsBannerCollectionViewCell
        
        cell.newsImageView.image = UIImage(named: "pic0")
        return cell
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

}
