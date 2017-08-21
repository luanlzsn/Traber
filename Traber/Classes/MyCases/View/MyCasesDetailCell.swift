//
//  MyCasesDetailCell.swift
//  Traber
//
//  Created by luan on 2017/4/22.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class MyCasesDetailCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imgView: UIImageView!
    var imgArray = [UIImage]()
    
    @IBAction func leftClick(_ sender: Any) {
        pageControl.currentPage -= 1
        if pageControl.currentPage < 0 {
            pageControl.currentPage = 0
        }
        collectionView.setContentOffset(CGPoint(x: (kScreenWidth - 30) * CGFloat(pageControl.currentPage), y: 0), animated: true)
        checkArrowStatus()
    }
    
    @IBAction func rightClick(_ sender: Any) {
        pageControl.currentPage += 1
        if pageControl.currentPage > imgArray.count - 1 {
            pageControl.currentPage = imgArray.count - 1
        }
        collectionView.setContentOffset(CGPoint(x: (kScreenWidth - 30) * CGFloat(pageControl.currentPage), y: 0), animated: true)
        checkArrowStatus()
    }
    
    func checkArrowStatus() {
        leftBtn.isEnabled = (pageControl.currentPage != 0)
        rightBtn.isEnabled = (pageControl.currentPage != imgArray.count - 1)
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    // MARK: UICollectionViewDelegate,UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MyCasesDetailImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCasesDetailImageCell", for: indexPath) as! MyCasesDetailImageCell
        cell.imgView.image = imgArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController()?.performSegue(withIdentifier: "LookPicture", sender: ["ImageArray":imgArray,"CurrentPage":indexPath.row])
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / (kScreenWidth - 30))
        checkArrowStatus()
    }
    
}
