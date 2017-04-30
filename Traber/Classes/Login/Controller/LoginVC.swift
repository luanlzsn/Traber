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
    }

    @IBAction func rememberClick(_ sender: UIButton) {
        rememberBtn.isSelected = !rememberBtn.isSelected
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        if !Common.isValidateEmail(email: emailField.text!) {
            AntManage.showDelayToast(message: "Please enter the corrent email!")
            return
        }
        if (passwordField.text?.isEmpty)! {
            AntManage.showDelayToast(message: "Password is required!")
            return
        }
        if rememberBtn.isSelected {
            UserDefaults.standard.set(emailField.text, forKey: kEmailKey)
            UserDefaults.standard.set(passwordField.text, forKey: kPassWordKey)
            UserDefaults.standard.set(true, forKey: kIsLoginKey)
        } else {
            UserDefaults.standard.set(nil, forKey: kEmailKey)
            UserDefaults.standard.set(nil, forKey: kPassWordKey)
        }
        UserDefaults.standard.synchronize()
        AntManage.isLogin = true
        AntManage.showDelayToast(message: "Login success!")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func facebookLoginClick(_ sender: UIButton) {
        
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
