//
//  RegisterVC.swift
//  Traber
//
//  Created by luan on 2017/4/30.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class RegisterVC: AntController {

    @IBOutlet weak var firstName: LoginTextField!
    @IBOutlet weak var lastName: LoginTextField!
    @IBOutlet weak var email: LoginTextField!
    @IBOutlet weak var password: LoginTextField!
    @IBOutlet weak var confirmPassword: LoginTextField!
    @IBOutlet weak var rememberBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func rememberClick(_ sender: UIButton) {
        rememberBtn.isSelected = !rememberBtn.isSelected
    }
    
    @IBAction func registerClick(_ sender: UIButton) {
        UIApplication.shared.keyWindow?.endEditing(true)
        if !rememberBtn.isSelected {
            AntManage.showDelayToast(message: NSLocalizedString("Please choice agreement", comment: ""))
            return
        }
        if (firstName.text?.isEmpty)! {
            AntManage.showDelayToast(message: NSLocalizedString("First Name is required", comment: ""))
            return
        }
        if (lastName.text?.isEmpty)! {
            AntManage.showDelayToast(message: NSLocalizedString("Last Name is required", comment: ""))
            return
        }
        if !Common.isValidateEmail(email: email.text!) {
            AntManage.showDelayToast(message: NSLocalizedString("Please enter the correct email", comment: ""))
            return
        }
        if (password.text?.isEmpty)! {
            AntManage.showDelayToast(message: NSLocalizedString("Password is required", comment: ""))
            return
        }
        if password.text != confirmPassword.text {
            AntManage.showDelayToast(message: NSLocalizedString("Two passwords are different", comment: ""))
            return
        }
        weak var weakSelf = self
        AntManage.postRequest(path: "user/register", params: ["source":"home","identity":email.text!,"password":password.text!,"retypePwd":confirmPassword.text!,"firstname":firstName.text!,"lastname":lastName.text!,"agree":"true","referenceID":""], successResult: { (response) in
            AntManage.showDelayToast(message: NSLocalizedString("Successful registration", comment: ""))
            weakSelf?.navigationController?.popViewController(animated: true)
        }, failureResult: {})
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
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
