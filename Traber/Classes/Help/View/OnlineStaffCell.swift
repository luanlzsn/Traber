//
//  OnlineStaffCell.swift
//  Traber
//
//  Created by luan on 2017/9/1.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class OnlineStaffCell: UITableViewCell,UIWebViewDelegate {

    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.scrollView.isScrollEnabled = false
    }
    
    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.background='#F6F6F6'")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == .formSubmitted {
            let url = request.url!
            viewController()!.performSegue(withIdentifier: "PaymentWeb", sender: url)
            return false
        }
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
