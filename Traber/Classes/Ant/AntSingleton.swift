//
//  LeomanSingleton.swift
//  MoFan
//
//  Created by luan on 2017/1/4.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

let kRequestTimeOut = 10.0
let AntManage = AntSingleton.sharedInstance

class AntSingleton: NSObject {
    
    static let sharedInstance = AntSingleton()
    var manager = AFHTTPSessionManager(baseURL: URL(string: kRequestBaseUrl))
    var progress : MBProgressHUD?
    var progressCount = 0//转圈数量
    var isLogin = false//是否登录
    var userModel: UserModel?
    let kNoHUDPathArray = ["chat/status"]
    
    private override init () {
        manager.responseSerializer.acceptableContentTypes = Set(arrayLiteral: "application/json","text/json","text/javascript","text/html")
        manager.requestSerializer = AFJSONRequestSerializer.init()
        manager.requestSerializer.timeoutInterval = kRequestTimeOut
    }
    
    //MARK: - post请求
    func postRequest(path:String, params:[String : Any]?, successResult:@escaping ([String : Any]) -> Void, failureResult:@escaping () -> Void) {
        AntLog(message: "请求接口：\(path),请求参数：\(String(describing: params))")
        if !kNoHUDPathArray.contains(path) {
            showMessage(message: "")
        }
        weak var weakSelf = self
        var params = params
        params?["source"] = UserDefaults.standard.bool(forKey: kIsFacebook) ? "facebook" : "home"
        manager.post(path, parameters: params, progress: nil, success: { (task, response) in
            weakSelf?.requestSuccess(response: response, successResult: successResult, failureResult: failureResult, path: path)
        }) { (task, error) in
            weakSelf?.hideMessage()
            weakSelf?.showDelayToast(message: NSLocalizedString("network server error", comment: ""))
            failureResult()
        }
    }
    
    //MARK: - post realpay请求
    func postRealpayRequest(path:String, params:String, successResult:@escaping ([String : Any]) -> Void, failureResult:@escaping () -> Void) {
        AntLog(message: "请求接口：\(path),请求参数：\(String(describing: params))")
        if !kNoHUDPathArray.contains(path) {
            showMessage(message: "")
        }

        let sarequestUrl = kRequestBaseUrl + path
        let formRequest = AFHTTPRequestSerializer().request(withMethod: "POST", urlString: sarequestUrl, parameters: nil, error: nil)
        formRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        formRequest.timeoutInterval = kRequestTimeOut
        formRequest.httpBody = params.mj_JSONData()
        
        let manager = AFHTTPSessionManager()
        
        let responseSerializer = AFJSONResponseSerializer()
        responseSerializer.acceptableContentTypes = Set(arrayLiteral: "application/json","text/json","text/javascript","text/html","text/plain")
        manager.responseSerializer = responseSerializer
        
        weak var weakSelf = self
        let dataTask = manager.dataTask(with: formRequest as URLRequest) { (response, data, error) in
            if error == nil {
                weakSelf?.requestSuccess(response: data, successResult: successResult, failureResult: failureResult, path: path)
            } else {
                weakSelf?.hideMessage()
                weakSelf?.showDelayToast(message: NSLocalizedString("network server error", comment: ""))
                failureResult()
            }
        }
        dataTask.resume()
    }
    
    //MARK: - get请求
    func getRequest(path:String, params:[String : Any]?, successResult:@escaping ([String : Any]) -> Void, failureResult:@escaping () -> Void) {
        AntLog(message: "请求接口：\(path),请求参数：\(String(describing: params))")
        showMessage(message: "")
        weak var weakSelf = self
        var params = params
        params?["source"] = UserDefaults.standard.bool(forKey: kIsFacebook) ? "facebook" : "home"
        manager.get(path, parameters: params, progress: nil, success: { (task, response) in
            weakSelf?.requestSuccess(response: response, successResult: successResult, failureResult: failureResult, path: path)
        }) { (task, error) in
            weakSelf?.hideMessage()
            weakSelf?.showDelayToast(message: NSLocalizedString("network server error", comment: ""))
            failureResult()
        }
    }
    
    //MARK: - 请求成功回调
    func requestSuccess(response: Any?, successResult:@escaping ([String : Any]) -> Void, failureResult:@escaping () -> Void, path: String) {
        AntLog(message: "接口返回数据：\(String(describing: response))")
        if !kNoHUDPathArray.contains(path) {
            hideMessage()
        }
        if let data = response as? [String : Any] {
            if let status = data["status"] {
                if status as! Int == 0 {
                    successResult(data)
                } else {
                    if let message = data["message"] as? String {
                        showDelayToast(message: message)
                    }
                    failureResult()
                }
            } else {
                failureResult()
            }
        } else {
            failureResult()
        }
    }
    
    
    //MARK: - 显示提示
    func showMessage(message : String) {
        if progress == nil {
            progressCount = 0
            progress = MBProgressHUD.showAdded(to: kWindow!, animated: true)
            progress?.label.text = message
        }
        progressCount += 1
    }
    
    //MARK: - 隐藏提示
    func hideMessage() {
        progressCount -= 1
        if progressCount < 0 {
            progressCount = 0
        }
        if (progress != nil) && progressCount == 0 {
            progress?.hide(animated: true)
            progress?.removeFromSuperview()
            progress = nil
        }
    }
    
    //MARK: - 显示固定时间的提示
    func showDelayToast(message : String) {
        let hud = MBProgressHUD.showAdded(to: kWindow!, animated: true)
        hud.detailsLabel.text = message
        hud.mode = .text
        hud.hide(animated: true, afterDelay: 2)
    }
    
}
