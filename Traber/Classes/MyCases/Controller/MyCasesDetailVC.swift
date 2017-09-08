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
    
    var ticketArray = [TicketModel]()
    var currentPage = 0
    var ticketDic = [Int:TicketModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.contentSize = CGSize(width: kScreenWidth * CGFloat(ticketArray.count), height: 0)
        collectionView.setContentOffset(CGPoint(x: kScreenWidth * CGFloat(currentPage), y: 0), animated: true)
        checkArrowStatus()
        getTicketDetail(ticketId: ticketArray[currentPage].ticketID)
    }
    
    func getTicketDetail(ticketId: Int) {
        weak var weakSelf = self
        AntManage.postRequest(path: "ticket/getTicket", params: ["identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token, "ticketID":ticketId], successResult: { (response) in
            weakSelf?.ticketDic[ticketId] = TicketModel.mj_object(withKeyValues: response["ticket"])
            weakSelf?.collectionView.reloadData()
        }, failureResult: {})
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
        if currentPage > ticketArray.count - 1 {
            currentPage = ticketArray.count - 1
        }
        collectionView.setContentOffset(CGPoint(x: kScreenWidth * CGFloat(currentPage), y: 0), animated: true)
        checkArrowStatus()
    }
    
    @IBAction func onlineChatClick(_ sender: UIButton) {
        
    }
    
    func checkArrowStatus() {
        leftBtn.isEnabled = (currentPage != 0)
        rightBtn.isEnabled = (currentPage != ticketArray.count - 1)
        let model = ticketArray[currentPage]
        caseNum.text = "Case " + model.caseNumber
        if ticketDic[model.ticketID] == nil {
            getTicketDetail(ticketId: model.ticketID)
        }
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
        return ticketArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MyCasesDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCasesDetailCell", for: indexPath) as! MyCasesDetailCell
        let model = ticketDic[ticketArray[indexPath.row].ticketID]
        if model != nil {
            let imgStr = model!.image.components(separatedBy: ",").last!
            let imgData = Data(base64Encoded: imgStr, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.imgView.image = UIImage(data: imgData!)
            cell.imgArray = [UIImage(data: imgData!)!]
        } else {
            cell.imgView.image = nil
            cell.imgArray = [UIImage]()
        }
        cell.collectionView.reloadData()
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
