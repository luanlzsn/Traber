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
        let payFee = Float(amout)! - Float(AntManage.userModel!.store_credit)!
        if payFee > 0 {
            if Float(AntManage.userModel!.store_credit)! > 0 {
                performSegue(withIdentifier: "Payment", sender: payFee)
            } else {
                performSegue(withIdentifier: "Payment", sender: Float(amout)!)
            }
        } else {
            weak var weakSelf = self
            AntManage.postRequest(path: "ticket/paySuccess", params: ["identity":UserDefaults.standard.object(forKey: kEmailKey)!, "token":AntManage.userModel!.token, "ticketID":ticketID, "paid_amount":"0.00", "used_credit":amout, "currency":"CAD"], successResult: { (_) in
                NotificationCenter.default.post(name: NSNotification.Name("PaySuccess"), object: nil)
                AntManage.showDelayToast(message: NSLocalizedString("Payment Successful.", comment: ""))
                weakSelf?.navigationController?.popToRootViewController(animated: true)
            }, failureResult: {})
        }
    }
    
    // MARK: - 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Payment" {
            let payment = segue.destination as! PaymentVC
            payment.amout = amout
            payment.ticketID = ticketID
            payment.payFeeF = sender as! Float
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
