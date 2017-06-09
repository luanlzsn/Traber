//
//  FileTicketVC.swift
//  Traber
//
//  Created by luan on 2017/5/1.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class FileTicketVC: AntController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let sectionArray = [["Title":"File Ticket","Explain":"Ut at consectetur nisl, gravida egestats nisl. Aliquam at ligula est...MORE","Button":"File","Identifier":"File"],["Title":"Request a Paralegal","Explain":"Phasellus lacus odio, ultrices ac volutpat eget, vehicula. lobortis.enim...MORE","Button":"Request","Identifier":"Request"],["Title":"Pay the Fine","Explain":"Donec a auctor elit. Mauris ornare finibus nunc.et interdum dolor blandit...MORE","Button":"Pay","Identifier":"InformationReview"]]
    var dataDic: [String : String]!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addTicket() {
        var params = ["source":"home", "identity":UserDefaults.standard.object(forKey: kEmailKey)!, "token":AntManage.userModel!.token, "infractionDate":dataDic["Date"]!, "location":dataDic["City"]!, "licenseName":AntManage.userModel!.licenseName, "licenseAddress":AntManage.userModel!.licenseAddress, "licenseCity":AntManage.userModel!.licenseCity, "licensePro":AntManage.userModel!.licensePro, "licenseCountry":AntManage.userModel!.licenseCountry, "licensePostcode":dataDic["PostCode"]!, "isDriverlicense":"1", "imageType":"jpeg"] as [String : Any]
        params["ticketType"] = (dataDic["Type"] == "Parking") ? "1" : "2"
        params["image"] = "data:image/jpeg;base64," + UIImageJPEGRepresentation(image, 0.1)!.base64EncodedString()
        params["fight_type"] = "Paralegal"
        weak var weakSelf = self
        AntManage.postRequest(path: "ticket/add", params: params, successResult: { (response) in
            weakSelf?.performSegue(withIdentifier: "Request", sender: nil)
        }, failureResult: {})
    }
    
    // MARK: UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == sectionArray.count - 1 ? 80 : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FileTicketCell = tableView.dequeueReusableCell(withIdentifier: "FileTicketCell", for: indexPath) as! FileTicketCell
        let dic = sectionArray[indexPath.section]
        cell.titleLable.text = NSLocalizedString(dic["Title"]!, comment: "")
        cell.explain.text = NSLocalizedString(dic["Explain"]!, comment: "")
        cell.button.setTitle(NSLocalizedString(dic["Button"]!, comment: ""), for: .normal)
        weak var weakSelf = self
        cell.ticketButtonClick = { (_) in
            if indexPath.section == 0 {
                
            } else if indexPath.section == 1 {
                weakSelf?.addTicket()
            } else {
                
            }
        }
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
