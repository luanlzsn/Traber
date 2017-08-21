//
//  HelpVC.swift
//  Traber
//
//  Created by luan on 2017/4/21.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class HelpVC: AntController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - 联系客服
    @IBAction func callCustomerServiceClick(_ sender: UIButton) {
        let telURL = URL(string: "tel://10086")!
        if UIApplication.shared.canOpenURL(telURL) {
            let callWebView = UIWebView.init()
            callWebView.loadRequest(URLRequest(url: telURL))
            view.addSubview(callWebView)
        } else {
            AntManage.showDelayToast(message: "该设备不支持电话拨打功能")
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
