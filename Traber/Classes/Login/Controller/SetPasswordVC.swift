//
//  SetPasswordVC.swift
//  Traber
//
//  Created by luan on 2017/4/30.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class SetPasswordVC: AntController {

    @IBOutlet weak var password: LoginTextField!
    @IBOutlet weak var confirmPassword: LoginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func confirmClick(_ sender: Any) {
        if (password.text?.isEmpty)! {
            AntManage.showDelayToast(message: "Password is required!")
            return
        }
        if password.text != confirmPassword.text {
            AntManage.showDelayToast(message: "Two passwords are different!")
            return
        }
        AntManage.showDelayToast(message: "Set Password success!")
        _ = navigationController?.popToRootViewController(animated: true)
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
