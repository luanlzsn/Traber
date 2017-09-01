//
//  CasesDetailVC.swift
//  Traber
//
//  Created by luan on 2017/8/31.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class CasesDetailVC: AntController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var ticketId = 0
    var ticketModel: TicketModel?
    var titleArray = [["Ticket Information", "Ticket ID", "Ticket Type", "Amount", "Additional Pay", "Infraction Date", "Court Date", "Submit Time"],["Car Owner's Information", "License Name", "License Address", "License City", "License Province", "License Country", "License Postcode"]]
    var contentArray = [["", "", "", "", "", "", "", "", ""],["", "", "", "", "", "", ""]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getTicketDetail()
    }
    
    func getTicketDetail() {
        weak var weakSelf = self
        AntManage.postRequest(path: "ticket/getTicket", params: ["source":"home", "identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token, "ticketID":ticketId], successResult: { (response) in
            weakSelf?.ticketModel = TicketModel.mj_object(withKeyValues: response["ticket"])
            weakSelf?.checkContent()
            weakSelf?.tableView.reloadData()
        }, failureResult: {
            weakSelf?.navigationController?.popViewController(animated: true)
        })
    }
    
    func checkContent() {
        contentArray[0].replaceSubrange(Range(1..<2), with: ["\(ticketModel!.ticketID)"])
        contentArray[0].replaceSubrange(Range(2..<3), with: [ticketModel!.statusID])
        contentArray[0].replaceSubrange(Range(3..<4), with: ["\(ticketModel!.amount)"])
        contentArray[0].replaceSubrange(Range(5..<6), with: [ticketModel!.infractionDate])
        contentArray[0].replaceSubrange(Range(6..<7), with: [ticketModel!.courtDate])
        contentArray[0].replaceSubrange(Range(7..<8), with: [ticketModel!.submitTm])
        
        contentArray[1].replaceSubrange(Range(1..<2), with: [ticketModel!.licenseName])
        contentArray[1].replaceSubrange(Range(2..<3), with: [ticketModel!.licenseAddress])
        contentArray[1].replaceSubrange(Range(3..<4), with: [ticketModel!.licenseCity])
        contentArray[1].replaceSubrange(Range(4..<5), with: [ticketModel!.licensePro])
        contentArray[1].replaceSubrange(Range(5..<6), with: [ticketModel!.licenseCountry])
        contentArray[1].replaceSubrange(Range(6..<7), with: [ticketModel!.licensePostcode])
    }

    @IBAction func onlineChatClick(_ sender: UIButton) {
        if ticketModel != nil {
            performSegue(withIdentifier: "OnlineChatList", sender: nil)
        }
    }
    
    // MARK: 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LookPicture" {
            let lookPicture = segue.destination as! LookPictureVC
            lookPicture.imgArray = [ticketModel!.image]
            lookPicture.currentPage  = 0
        } else if segue.identifier == "OnlineChatList" {
            let chat = segue.destination as! OnlineChatListVC
            chat.ticketID = ticketModel!.ticketID
        }
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return (ticketModel == nil) ? 0 : 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return titleArray[section - 1].count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return (kScreenWidth - 30) / 2.0 + 40
        } else {
            return 25
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 10 : 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: CasesDetailImageCell = tableView.dequeueReusableCell(withIdentifier: "CasesDetailImageCell", for: indexPath) as! CasesDetailImageCell
            cell.caseNum.text = NSLocalizedString("Case", comment: "") + " " + ticketModel!.caseNumber
            let imgStr = ticketModel!.image.components(separatedBy: ",").last!
            let imgData = Data(base64Encoded: imgStr, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.caseImage.image = UIImage(data: imgData!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CasesDetailCell", for: indexPath)
            if indexPath.row == 0 {
                cell.textLabel?.textColor = UIColor(rgb: 0x229D68)
                cell.textLabel?.text = NSLocalizedString(titleArray[indexPath.section - 1][indexPath.row], comment: "")
            } else {
                cell.textLabel?.textColor = UIColor(rgb: 0x6D6D72)
                cell.textLabel?.text = NSLocalizedString(titleArray[indexPath.section - 1][indexPath.row], comment: "") + ":" + contentArray[indexPath.section - 1][indexPath.row]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "LookPicture", sender: nil)
        }
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
