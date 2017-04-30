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
    let imgArray = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492877012680&di=cfb554748dfa9b8a73ab360fc46eda8d&imgtype=0&src=http%3A%2F%2Fimage.bitauto.com%2Fdealer%2Fnews%2F100083481%2Faf60db2d-b527-479b-85db-1b40dd5f063d.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1493442218&di=acf285df9882654682adc603c680e308&src=http://news.ynxxb.com/Upload/News/2013-6/11/N10856972328/s01534751996.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493452326356&di=e0c3dcf32ee1e340c22c25f24fb785d1&imgtype=0&src=http%3A%2F%2Fe.hznews.com%2Fdata%2Fdjsb%2F2016%2F0502%2FA6502C_6.jpg"]
    
    
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
        cell.imgView.sd_setImage(with: URL(string: imgArray[indexPath.row]))
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
