//
//  PaymentVC.swift
//  Traber
//
//  Created by luan on 2017/4/21.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit
import Stripe

class PaymentVC: AntController,UITextFieldDelegate {
    
    @IBOutlet weak var totalFee: UILabel!
    @IBOutlet weak var payFee: UITextField!
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expirationDate: UITextField!
    @IBOutlet weak var cvc: UITextField!
    var amout = ""
    var ticketID = 0
    var payFeeF: Float = 0.00
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalFee.text = "$" + amout
        payFee.text = String.init(format: "%.2f", payFeeF)
    }

    @IBAction func submitPaymentClick(_ sender: UIButton) {
        kWindow?.endEditing(true)
        if cardName.text!.isEmpty {
            AntManage.showDelayToast(message: NSLocalizedString("Card Holder's Name is required", comment: ""))
            return
        }
        if cardNumber.text!.isEmpty {
            AntManage.showDelayToast(message: NSLocalizedString("Card Number is required", comment: ""))
            return
        }
        if expirationDate.text!.isEmpty {
            AntManage.showDelayToast(message: NSLocalizedString("Expiration Date is required", comment: ""))
            return
        }
        if cvc.text!.isEmpty {
            AntManage.showDelayToast(message: NSLocalizedString("CVC is required", comment: ""))
            return
        }
        
        let cardParams = STPCardParams()
        cardParams.name = cardName.text
        cardParams.number = cardNumber.text
        cardParams.expMonth = UInt(expirationDate.text!.components(separatedBy: "/").first!)!
        cardParams.expYear = UInt(expirationDate.text!.components(separatedBy: "/").last!)!
        cardParams.cvc = cvc.text
        
        weak var weakSelf = self
        AntManage.showMessage(message: "")
        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            AntManage.hideMessage()
            guard let token = token, error == nil else {
                // Present error to user...
                if error != nil {
                    AntManage.showDelayToast(message: (error! as NSError).localizedDescription)
                }
                return
            }
            weakSelf?.submitTokenToBackend(token: token)
        }
    }
    
    func submitTokenToBackend(token: STPToken) {
        weak var weakSelf = self
        AntManage.postRequest(path: "ticket/paySuccess", params: ["identity":UserDefaults.standard.object(forKey: kEmailKey)!, "token":AntManage.userModel!.token, "ticketID":ticketID, "paid_amount":payFee.text!, "used_credit":AntManage.userModel!.store_credit], successResult: { (_) in
            AntManage.showDelayToast(message: NSLocalizedString("Pay Success!", comment: ""))
            weakSelf?.navigationController?.popToRootViewController(animated: true)
        }, failureResult: {})
    }
    
    // MARK: - 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ExpirationDate" {
            let expirationDate = segue.destination as! InfractionDateVC
            weak var weakSelf = self
            expirationDate.checkCardExpirationDate(confirmBlock: { (dateStr) in
                weakSelf?.expirationDate.text = (dateStr as? String) ?? ""
            })
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        kWindow?.endEditing(true)
        performSegue(withIdentifier: "ExpirationDate", sender: nil)
        return false
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
