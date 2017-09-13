//
//  PushNotificationCell.swift
//  Traber
//
//  Created by luan on 2017/5/14.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

@objc protocol PushNotificationCell_Delegate {
    func switchChange(isOn: Bool)
}

class PushNotificationCell: UITableViewCell {

    @IBOutlet weak var switchBtn: UISwitch!
    weak var delegate: PushNotificationCell_Delegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func switchChangedClick(_ sender: UISwitch) {
        delegate?.switchChange(isOn: sender.isOn)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
