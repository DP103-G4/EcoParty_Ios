//
//  PartyViewController.swift
//  EcoParty_Ios
//
//  Created by 陳博軒 on 2020/2/17.
//  Copyright © 2020 Bozin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PartyCollectionViewCell"

class PartyViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PartyCollectionViewCell
        cell.partyImage.image = UIImage(named: "item0")
        cell.partyOwnerImage.image = UIImage(named: "woman")
        
            return cell
    }
    

    @IBOutlet weak var partyCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var partyCollectionViewControl: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = (partyCollectionViewControl.bounds.width - 5 * 2) / 2
        let layout = partyCollectionViewFlowLayout
        layout?.itemSize = CGSize(width: width, height: width + 55)
        //        設為.zero如此cell的尺寸才會依據itemSize否則將從autoLayout的條件計算cell的尺寸
                layout?.estimatedItemSize = .zero
        
     
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
