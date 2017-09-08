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

        if UserDefaults.standard.bool(forKey: kIsFacebook) {
            facebookRegister(user: NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: kFacebookUserInfo) as! Data) as! SSDKUser)
        } else {
            emailField.text = UserDefaults.standard.string(forKey: kEmailKey)
            passwordField.text = UserDefaults.standard.string(forKey: kPassWordKey)
            if UserDefaults.standard.bool(forKey: kIsRemember) {
                loginClick()
            }
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
        AntManage.postRequest(path: "user/login", params: ["identity":emailField.text!, "password":passwordField.text!], successResult: { (response) in
            UserDefaults.standard.set(weakSelf?.emailField.text, forKey: kEmailKey)
            UserDefaults.standard.set(weakSelf?.passwordField.text, forKey: kPassWordKey)
            UserDefaults.standard.set(weakSelf?.rememberBtn.isSelected, forKey: kIsRemember)
            UserDefaults.standard.set(false, forKey: kIsFacebook)
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
                weakSelf?.facebookRegister(user: user!)
            }
        }
    }
    
    func facebookRegister(user: SSDKUser) {
        weak var weakSelf = self
        AntManage.postRequest(path: "user/register", params: ["identity":user.uid,"password":"","retypePwd":"","firstname":user.rawData["first_name"]!,"lastname":user.rawData["last_name"]!,"agree":"true","referenceID":""], successResult: { (response) in
            weakSelf?.facebookLoginRequest(user: user)
        }, failureResult: {})
    }
    
    func facebookLoginRequest(user: SSDKUser) {
        weak var weakSelf = self
        AntManage.postRequest(path: "user/login", params: ["identity":user.uid, "password":""], successResult: { (response) in
            UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: user), forKey: kFacebookUserInfo)
            UserDefaults.standard.set(user.uid, forKey: kEmailKey)
            UserDefaults.standard.set(true, forKey: kIsFacebook)
            UserDefaults.standard.synchronize()
            AntManage.isLogin = true
            AntManage.userModel = UserModel.mj_object(withKeyValues: response)
            AntManage.showDelayToast(message: NSLocalizedString("Login success", comment: ""))
            weakSelf?.dismiss(animated: true, completion: nil)
        }, failureResult: {})
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
