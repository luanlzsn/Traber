//
//  LeomanDefault.swift
//  MoFan
//
//  Created by luan on 2016/12/8.
//  Copyright © 2016年 luan. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import YYCategories
import MJExtension

func AntLog<N>(message:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line){
    #if DEBUG
        print("类\(fileName as NSString)的\(methodName)方法第\(lineNumber)行:\(message)");
    #endif
}

#if DEBUG
    let kRequestBaseUrl = "http://123.59.155.131:8080/ruanfan/api/"    
#else
    let kRequestBaseUrl = "http://123.59.155.131:8080/ruanfan/api/"
#endif

let kWindow = UIApplication.shared.keyWindow
let kScreenBounds = UIScreen.main.bounds
let kScreenWidth = kScreenBounds.width
let kScreenHeight = kScreenBounds.height
let MainColor = Common.colorWithHexString(colorStr: "80D3CB")
let LeomanManager = AntSingleton.sharedInstance
let kIphone4 = kScreenHeight == 480
let kIpad = UIDevice.current.userInterfaceIdiom == .pad
let kAppDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
let kAppVersion_URL = "http://itunes.apple.com/lookup?id=1107512125"//获取版本信息
let kAppDownloadURL = "https://itunes.apple.com/cn/app/id1107512125"//下载地址

let kEmailKey = "kEmailKey"
let kPassWordKey = "kPassWordKey"
let kIsRemember = "kIsRemember"
let kIsFacebook = "kIsFacebook"//是否是Facebook登录
let kFacebookUserInfo = "kFacebookUserInfo"//Facebook的登录信息
let kIsOnNotification = "kIsOnNotification"//通知开关(控制是否轮询消息)


struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

typealias ConfirmBlock = (_ value: Any) ->Void
typealias CancelBlock = () ->Void

