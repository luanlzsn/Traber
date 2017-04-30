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
        if !rememberBtn.isSelected {
            AntManage.showDelayToast(message: "Please choice agreement!")
            return
        }
        if (firstName.text?.isEmpty)! {
            AntManage.showDelayToast(message: "First Name is required!")
            return
        }
        if (lastName.text?.isEmpty)! {
            AntManage.showDelayToast(message: "Last Name is required!")
            return
        }
        if !Common.isValidateEmail(email: email.text!) {
            AntManage.showDelayToast(message: "Please enter the corrent email!")
            return
        }
        if (password.text?.isEmpty)! {
            AntManage.showDelayToast(message: "Password is required!")
            return
        }
        if password.text != confirmPassword.text {
            AntManage.showDelayToast(message: "Two passwords are different!")
            return
        }
        AntManage.showDelayToast(message: "Register success!")
        _ = navigationController?.popViewController(animated: true)
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