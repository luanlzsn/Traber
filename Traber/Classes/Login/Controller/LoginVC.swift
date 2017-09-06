//
//  LoginVC.swift
//  Traber
//
//  Created by luan on 2017/4/29.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class LoginVC: AntController {

    @IBOutlet weak var emailField: LoginTextField!
    @IBOutlet weak var passwordField: LoginTextField!
    @IBOutlet weak var rememberBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.text = UserDefaults.standard.string(forKey: kEmailKey)
        passwordField.text = UserDefaults.standard.string(forKey: kPassWordKey)
        if UserDefaults.standard.bool(forKey: kisRemember) {
            loginClick()
        }
    }

    @IBAction func rememberClick(_ sender: UIButton) {
        rememberBtn.isSelected = !rememberBtn.isSelected
    }
    
    @IBAction func loginClick() {
        UIApplication.shared.keyWindow?.endEditing(true)
        if !Common.isValidateEmail(email: emailField.text!) {
            AntManage.showDelayToast(message: NSLocalizedString("Please enter the correct email", comment: ""))
            return
        }
        if (passwordField.text?.isEmpty)! {
            AntManage.showDelayToast(message: NSLocalizedString("Password is required", comment: ""))
            return
        }
        weak var weakSelf = self
        AntManage.postRequest(path: "user/login", params: ["source":"home", "identity":emailField.text!, "password":passwordField.text!], successResult: { (response) in
            UserDefaults.standard.set(weakSelf?.emailField.text, forKey: kEmailKey)
            UserDefaults.standard.set(weakSelf?.passwordField.text, forKey: kPassWordKey)
            UserDefaults.standard.set(weakSelf?.rememberBtn.isSelected, forKey: kisRemember)
            UserDefaults.standard.synchronize()
            AntManage.isLogin = true
            AntManage.userModel = UserModel.mj_object(withKeyValues: response)
            AntManage.showDelayToast(message: NSLocalizedString("Login success", comment: ""))
            weakSelf?.dismiss(animated: true, completion: nil)
        }, failureResult: {})
    }
    
    @IBAction func facebookLoginClick(_ sender: UIButton) {
        weak var weakSelf = self
        ShareSDK.getUserInfo(SSDKPlatformType.typeFacebook) { (state, user, error) in
            if state == SSDKResponseState.success {
                
            }
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
