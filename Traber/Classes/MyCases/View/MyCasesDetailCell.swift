//
//  MyCasesDetailCell.swift
//  Traber
//
//  Created by luan on 2017/4/22.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class MyCasesDetailCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBAction func leftClick(_ sender: Any) {
        
    }
    
    @IBAction func rightClick(_ sender: Any) {
        
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    // MARK: UICollectionViewDelegate,UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MyCasesDetailImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCasesDetailImageCell", for: indexPath) as! MyCasesDetailImageCell
        cell.imgView.sd_setImage(with: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492877012680&di=cfb554748dfa9b8a73ab360fc46eda8d&imgtype=0&src=http%3A%2F%2Fimage.bitauto.com%2Fdealer%2Fnews%2F100083481%2Faf60db2d-b527-479b-85db-1b40dd5f063d.jpg"))
        return cell
    }
    
}
