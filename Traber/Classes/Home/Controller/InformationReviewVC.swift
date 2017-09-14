//
//  InformationReviewVC.swift
//  Traber
//
//  Created by luan on 2017/5/1.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class InformationReviewVC: AntController {
    
    @IBOutlet weak var fineAmount: UITextField!
    @IBOutlet weak var fees: UILabel!
    var dataDic: [String : String]!
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        checkTextFieldLeftView(textField: fineAmount)
        if dataDic["FightType"] == "File" {
            fees.text = "$599"
        } else {
            fees.text = "$1.99"
        }
    }

    @IBAction func paymentClick(_ sender: UIButton) {
        kWindow?.endEditing(true)
        if fineAmount.text!.isEmpty {
            AntManage.showDelayToast(message: NSLocalizedString("Fine amount is required", comment: ""))
            return
        }
        if Float(fineAmount.text!) == nil {
            AntManage.showDelayToast(message: NSLocalizedString("Fine amount is number", comment: ""))
            return
        }
        var amout = ""
        if dataDic["FightType"] == "File" {
            amout = "\(599 + Int(fineAmount.text!)!)"
        } else {
            amout = String.init(format: "%.2f", 1.99 + Float(fineAmount.text!)!)
        }
        var params = ["identity":UserDefaults.standard.object(forKey: kEmailKey)!, "token":AntManage.userModel!.token, "infractionDate":dataDic["Date"]!, "location":dataDic["City"]!, "unit_number":dataDic["UnitNo"]!, "licenseName":dataDic["Name"]!, "licenseAddress":AntManage.userModel!.licenseAddress, "licenseCity":AntManage.userModel!.licenseCity, "licensePro":AntManage.userModel!.licensePro, "licenseCountry":AntManage.userModel!.licenseCountry, "licensePostcode":dataDic["PostCode"]!, "imageType":"jpeg", "evidence":dataDic["Evidence"]!, "trial_language":dataDic["TrialLanguage"]!, "interpreter":dataDic["Interpreter"]!, "amount":amout] as [String : Any]
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
        params["fight_type"] = dataDic["FightType"]!
        weak var weakSelf = self
        AntManage.postRequest(path: "ticket/add", params: params, successResult: { (response) in
            weakSelf?.performSegue(withIdentifier: "TicketPayment", sender: ["TicketID":response["ticketID"], "Amount":amout])
        }, failureResult: {})
    }
    
    // MARK: - 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TicketPayment" {
            let payment = segue.destination as! TicketPaymentVC
            payment.fineAmountStr = fineAmount.text!
            payment.feesStr = fees.text!
            payment.ticketID = (sender as! [String : Any])["TicketID"] as! Int
            payment.amout = (sender as! [String : Any])["Amount"] as! String
        }
    }
    
    func checkTextFieldLeftView(textField: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.height))
        textField.leftView = leftView
        textField.leftViewMode = .always
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
