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
    var pushNotify = ""
    var caseNotify = ""
    var store_credit = ""
    var referenceUrl = ""
    var licenseName = ""
    var licenseAddress = ""
    var licenseCity = ""
    var licensePro = ""
    var licenseCountry = ""
    var licensePostcode = ""
}

class TicketModel: AntModel {
    var caseNumber = ""
    var image = ""
    var infractionDate = ""
    var payInfo = ""
    var statusID = ""
    var submitTm = ""
    var ticketID = 0
    var ticketNumber = ""
    var ticketType = 0
    var userRead = 0
}
