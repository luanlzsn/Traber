//
//  OnlineChatVC.swift
//  Traber
//
//  Created by luan on 2017/8/21.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class OnlineChatVC: AntController,UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func submitClick(_ sender: UIButton) {
        kWindow?.endEditing(true)
        if textView.text.isEmpty {
            AntManage.showDelayToast(message: "No message")
            return
        }
        weak var weakSelf = self
        AntManage.postRequest(path: "chat/add/user", params: ["source":"home", "identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token, "agentID":0, "message":textView.text], successResult: { (response) in
            AntManage.showDelayToast(message: "Send message success")
            weakSelf?.navigationController?.popViewController(animated: true)
        }, failureResult: {})
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
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
