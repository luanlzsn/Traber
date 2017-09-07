//
//  TicketPaymentVC.swift
//  Traber
//
//  Created by luan on 2017/8/31.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class TicketPaymentVC: AntController {

    @IBOutlet weak var fineAmount: UILabel!
    @IBOutlet weak var fees: UILabel!
    var fineAmountStr = ""
    var feesStr = ""
    var amout = ""
    var ticketID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fineAmount.text = fineAmountStr
        fees.text = feesStr
    }
    
    @IBAction func payClick(_ sender: UIButton) {
        performSegue(withIdentifier: "Payment", sender: nil)
//        weak var weakSelf = self
//        AntManage.postRequest(path: "ticket/paySuccess", params: ["source":"home", "identity":UserDefaults.standard.object(forKey: kEmailKey)!, "token":AntManage.userModel!.token, "ticketID":ticketID], successResult: { (_) in
//            AntManage.showDelayToast(message: NSLocalizedString("Pay Success!", comment: ""))
//            weakSelf?.navigationController?.popToRootViewController(animated: true)
//        }, failureResult: {})
    }
    
    // MARK: - 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Payment" {
            let payment = segue.destination as! PaymentVC
            payment.amout = amout
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
