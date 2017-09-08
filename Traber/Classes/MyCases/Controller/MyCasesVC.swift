//
//  MyCasesVC.swift
//  Traber
//
//  Created by luan on 2017/4/21.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class MyCasesVC: AntController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var ticketArray = [TicketModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weak var weakSelf = self
        AntManage.postRequest(path: "ticket", params: ["identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token], successResult: { (response) in
            weakSelf?.ticketArray = TicketModel.mj_objectArray(withKeyValuesArray: response["tickets"]) as! [TicketModel]
            weakSelf?.tableView.reloadData()
        }, failureResult: {
            weakSelf?.navigationController?.popViewController(animated: true)
        })
    }
    
    // MARK: 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyCasesDetail" {
            let detail = segue.destination as! MyCasesDetailVC
            detail.ticketArray = ticketArray
            detail.currentPage = sender as! Int
        } else if segue.identifier == "CasesDetail" {
            let detail = segue.destination as! CasesDetailVC
            detail.ticketId = ticketArray[sender as! Int].ticketID
        }
    }
    
    // MARK: UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return ticketArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 9 ? 10 : 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MyCasesCell = tableView.dequeueReusableCell(withIdentifier: "MyCasesCell", for: indexPath) as! MyCasesCell
        let model = ticketArray[indexPath.section]
        cell.caseNum.text = NSLocalizedString("Case", comment: "") + " " + model.caseNumber
        cell.statusLabel.text = model.statusID
        cell.statusImage.isHidden = !(model.statusID == "Paid")
        cell.infractionDate.text = model.infractionDate
        cell.city.text = ""
        cell.fileDate.text = model.submitTm.components(separatedBy: " ").first
        cell.courtDate.text = model.courtDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        performSegue(withIdentifier: "MyCasesDetail", sender: indexPath.section)
        performSegue(withIdentifier: "CasesDetail", sender: indexPath.section)
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
