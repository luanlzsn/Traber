//
//  EditProfileCell.swift
//  Traber
//
//  Created by luan on 2017/4/30.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

@objc protocol EditProfile_Delegate {
    func textFieldBeginEditing(indexPath: IndexPath)
    func textFieldEndEditing(textField: UITextField, indexPath: IndexPath)
}

class EditProfileCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var lineView: UIView!
    var indexPath = IndexPath()
    weak var delegate : EditProfile_Delegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldBeginEditing(indexPath: indexPath)
        lineView.backgroundColor = UIColor.init(rgb: 0x229d68)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldEndEditing(textField: textField, indexPath: indexPath)
        lineView.backgroundColor = UIColor.init(rgb: 0xc7c7cc)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
