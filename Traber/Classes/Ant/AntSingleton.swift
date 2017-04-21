//
//  LeomanSingleton.swift
//  MoFan
//
//  Created by luan on 2017/1/4.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

let kRequestTimeOut = 10.0

class AntSingleton: NSObject {
    
    static let sharedInstance = AntSingleton()
    var isLogin = false//是否登录
    var magazineYearArray = [Int]()//杂志年份信息
    
    private override init () {
        
    }
    
}
