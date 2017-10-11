//
//  ShareWebVC.swift
//  Traber
//
//  Created by luan on 2017/8/21.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class ShareWebVC: AntController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let shareUrl = "http://ticketez.com/FrontendWeb/home/?token=" + AntManage.userModel!.token + "&identity="
        + AntManage.userModel!.identity + "&redirecturl=refer&source=home"
        webView.loadRequest(URLRequest(url: URL(string: shareUrl)!))
    }
    
    // MARK: - UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        AntManage.showMessage(message: "")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        AntManage.hideMessage()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        AntManage.hideMessage()
        AntManage.showDelayToast(message: NSLocalizedString("Failed to load. Please try again", comment: ""))
        navigationController?.popViewController(animated: true)
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
