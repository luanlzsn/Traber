//
//  MyCasesDetailVC.swift
//  Traber
//
//  Created by luan on 2017/4/21.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class MyCasesDetailVC: AntController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {

    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var caseNum: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var caseNumArray = [String]()
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.contentSize = CGSize(width: kScreenWidth * CGFloat(caseNumArray.count), height: 0)
        collectionView.setContentOffset(CGPoint(x: kScreenWidth * CGFloat(currentPage), y: 0), animated: true)
        checkArrowStatus()
    }
    
    @IBAction func leftClick(_ sender: UIButton) {
        currentPage -= 1
        if currentPage < 0 {
            currentPage = 0
        }
        collectionView.setContentOffset(CGPoint(x: kScreenWidth * CGFloat(currentPage), y: 0), animated: true)
        checkArrowStatus()
    }
    
    @IBAction func rightClick(_ sender: UIButton) {
        currentPage += 1
        if currentPage > caseNumArray.count - 1 {
            currentPage = caseNumArray.count - 1
        }
        collectionView.setContentOffset(CGPoint(x: kScreenWidth * CGFloat(currentPage), y: 0), animated: true)
        checkArrowStatus()
    }
    
    @IBAction func onlineChatClick(_ sender: UIButton) {
        
    }
    
    func checkArrowStatus() {
        leftBtn.isEnabled = (currentPage != 0)
        rightBtn.isEnabled = (currentPage != caseNumArray.count - 1)
        caseNum.text = "Case " + caseNumArray[currentPage]
    }
    
    // MARK: 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LookPicture" {
            let lookPicture = segue.destination as! LookPictureVC
            lookPicture.imgArray = (sender as! [String : Any])["ImageArray"] as! [Any]
            lookPicture.currentPage  = (sender as! [String : Any])["CurrentPage"] as! Int
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
    
    // MARK: UICollectionViewDelegate,UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return caseNumArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MyCasesDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCasesDetailCell", for: indexPath) as! MyCasesDetailCell
        cell.imgView.sd_setImage(with: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492764217372&di=d31292ce1c8c20348b6bb22a3d87323e&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201509%2F10%2F20150910225146_hFfnK.thumb.224_0.jpeg"))
        return cell
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / kScreenWidth)
        checkArrowStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
