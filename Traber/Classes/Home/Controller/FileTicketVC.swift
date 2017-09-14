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
    let sectionArray = [["Title":"File Ticket", "Explain":"UI at consectetur nisl, gravida egestats nisl. Aliquam at ligula est...MORE", "Button":"File", "Identifier":"File"],["Title":"Request a Paralegal", "Explain":"Phasellus lacus odio, ultrices ac volutpat eget, vehicula. lobortis.enim...MORE", "Button":"Request", "Identifier":"Request"],["Title":"Pay the Fine", "Explain":"Donec a auctor elit.Mauris ornare finibus nunc.et interdum dolor blandit...MORE", "Button":"Pay", "Identifier":"InformationReview"]]
    var dataDic: [String : String]!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addTicket(_ identifier: String) {
        var params = ["identity":UserDefaults.standard.object(forKey: kEmailKey)!, "token":AntManage.userModel!.token, "infractionDate":dataDic["Date"]!, "location":dataDic["City"]!, "unit_number":dataDic["UnitNo"]!, "licenseName":dataDic["Name"]!, "licenseAddress":AntManage.userModel!.licenseAddress, "licenseCity":AntManage.userModel!.licenseCity, "licensePro":AntManage.userModel!.licensePro, "licenseCountry":AntManage.userModel!.licenseCountry, "licensePostcode":dataDic["PostCode"]!, "imageType":"jpeg", "evidence":"Yes", "trial_language":"", "interpreter":"No", "amount":""] as [String : Any]
        if dataDic["Type"] == "Parking" {
            params["ticketType"] = "1"
            params["isDriverlicense"] = "0"
            params["carType"] = ""
        } else {
            params["ticketType"] = "2"
            params["isDriverlicense"] = "1"
            params["carType"] = "1"
        }
        params["image"] = "data:image/jpeg;base64," + UIImageJPEGRepresentation(image, 0.1)!.base64EncodedString()
        params["fight_type"] = "Paralegal"
        weak var weakSelf = self
        AntManage.postRequest(path: "ticket/add", params: params, successResult: { (response) in
            weakSelf?.performSegue(withIdentifier: identifier, sender: nil)
        }, failureResult: {})
    }
    
    // MARK: - 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "File" {
            let file = segue.destination as! FileVC
            dataDic["FightType"] = "File"
            file.dataDic = dataDic
            file.image = image
        } else if segue.identifier == "InformationReview" {
            let info = segue.destination as! InformationReviewVC
            dataDic["FightType"] = "Pay"
            dataDic["Evidence"] = "Yes"
            dataDic["TrialLanguage"] = ""
            dataDic["Interpreter"] = "No"
            info.dataDic = dataDic
            info.image = image
        }
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
                weakSelf?.performSegue(withIdentifier: "File", sender: nil)
            } else if indexPath.section == 1 {
                let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                sheet.addAction(UIAlertAction(title: NSLocalizedString("Submit Request", comment: ""), style: .default, handler: { (_) in
                    weakSelf?.addTicket("Request")
                }))
                sheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel Request", comment: ""), style: .cancel, handler: nil))
                weakSelf?.present(sheet, animated: true, completion: nil)
            } else {
                weakSelf?.performSegue(withIdentifier: "InformationReview", sender: nil)
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
