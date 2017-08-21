//
//  ShareCaseVC.swift
//  Traber
//
//  Created by luan on 2017/5/1.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class ShareCaseVC: AntController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var ticketArray = [TicketModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weak var weakSelf = self
        AntManage.postRequest(path: "ticket", params: ["source":"home", "identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token], successResult: { (response) in
            weakSelf?.ticketArray = TicketModel.mj_objectArray(withKeyValuesArray: response["tickets"]) as! [TicketModel]
            weakSelf?.collectionView.reloadData()
        }, failureResult: {
            weakSelf?.navigationController?.popViewController(animated: true)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    @IBAction func cancelClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDelegate,UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ticketArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ShareCaseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareCaseCell", for: indexPath) as! ShareCaseCell
        let model = ticketArray[indexPath.section]
        cell.caseNum.text = "Case " + model.caseNumber
        cell.statusLabel.text = model.statusID
        cell.statusImage.isHidden = !(model.statusID == "Paid")
        let imgStr = model.image.components(separatedBy: ",").last!
        let imgData = Data(base64Encoded: imgStr, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        cell.imgView.image = UIImage(data: imgData!)
        return cell
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
