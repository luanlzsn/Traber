//
//  ForgotPasswordVC.swift
//  Traber
//
//  Created by luan on 2017/4/30.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class ForgotPasswordVC: AntController {

    @IBOutlet weak var emailField: LoginTextField!
    @IBOutlet weak var codeField: UITextField!
    let codeBtn = UIButton(type: .custom)
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        codeBtn.setTitle("GET CODE", for: .normal)
//        codeBtn.setTitleColor(UIColor.init(rgb: 0x229d68), for: .normal)
//        codeBtn.setTitleColor(UIColor.gray, for: .disabled)
//        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        codeBtn.contentHorizontalAlignment = .left
//        codeBtn.addTarget(self, action: #selector(self.obtainCodeClick), for: .touchUpInside)
//        let btnWidth = "GET CODE".width(for: UIFont.systemFont(ofSize: 14))
//        codeBtn.frame = CGRect(x: 0, y: 0, width: btnWidth + 10, height: 45)
//        codeField.rightView = codeBtn
//        codeField.rightViewMode = .always
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        count = 0
    }

    @IBAction func nextClick(_ sender: UIButton) {
        if !Common.isValidateEmail(email: emailField.text!) {
            AntManage.showDelayToast(message: NSLocalizedString("Please enter the correct email", comment: ""))
            return
        }
//        if (codeField.text?.isEmpty)! {
//            AntManage.showDelayToast(message: "Code is required!")
//            return
//        }
//        performSegue(withIdentifier: "SetPassword", sender: nil)
        weak var weakSelf = self
        AntManage.postRequest(path: "user/forget", params: ["identity":emailField.text!], successResult: { (_) in
            AntManage.showDelayToast(message: "Please check your email")
            weakSelf?.navigationController?.popViewController(animated: true)
        }, failureResult: {
            
        })
    }
    
    func obtainCodeClick() {
        if !Common.isValidateEmail(email: emailField.text!) {
            AntManage.showDelayToast(message: NSLocalizedString("Please enter the correct email", comment: ""))
            return
        }
        count = 60
        countDown()
    }
    
    func countDown() {
        count -= 1
        if count <= 0 {
            codeBtn.isEnabled = true
            let btnWidth = "GET CODE".width(for: UIFont.systemFont(ofSize: 14))
            codeBtn.width = btnWidth + 10
        } else {
            codeBtn.isEnabled = false
            codeBtn.setTitle("\(count)s get again", for: .disabled)
            let btnWidth = "\(count)s get again".width(for: UIFont.systemFont(ofSize: 14))
            codeBtn.width = btnWidth + 10
            perform(#selector(countDown), afterDelay: 1)
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
