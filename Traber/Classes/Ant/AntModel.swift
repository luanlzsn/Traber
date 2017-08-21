//
//  AntModel.swift
//  Traber
//
//  Created by luan on 2017/6/6.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class AntModel: NSObject {

}

class UserModel: AntModel {
    var token = ""
    var image = ""
    var firstname = ""
    var lastname = ""
    var email = ""
    var identity = ""
    var phone = ""
    var address = ""
    var city = ""
    var province = ""
    var country = ""
    var pushNotify = ""//推送通知
    var caseNotify = ""//案例的通知
    var store_credit = ""//商店信用
    var referenceUrl = ""//参考地址
    var licenseName = ""//许可证名称
    var licenseAddress = ""//许可证地址
    var licenseCity = ""//许可证城市
    var licensePro = ""//许可证身份/洲？
    var licenseCountry = ""//许可证国家
    var licensePostcode = ""//许可证编号
    var unit_number = ""
}

class TicketModel: AntModel {
    var caseNumber = ""//案件编号
    var image = ""
    var infractionDate = ""//违法日期
    var payInfo = ""//支付信息
    var statusID = ""
    var submitTm = ""//提交时间
    var ticketID = 0
    var ticketNumber = ""
    var ticketType = 0
    var userRead = 0//用户是否已读？
    var agentID = 0//代理人ID
    var agentRead = 0//代理人是否已读？
    var amount = 0.0//金额
    var carType = 0//车辆类型
    var courtDate = ""//开庭日期
    var evidence = ""//证据
    var fight_type = ""
    var interpreter = ""//解释者
    var ip = ""
    var lastUpdate = ""//最后修改时间
    var lawyerID = 0//律师id
    var lawyerRead = 0//律师是否已读？
    var licenseAddress = ""//许可证地址
    var licenseCity = ""//许可证城市
    var licenseCountry = ""//许可证国家
    var licenseName = ""//许可证名称
    var licensePostcode = ""//许可证编号
    var licensePro = ""//许可证身份/洲？
    var location = ""//位置
    var memos = ""//备忘录
    var note = ""//笔记
    var trial_language = ""//庭审语言
    var userID = 0//用户ID
    var isDetail = false//是否请求了详情
    
}
