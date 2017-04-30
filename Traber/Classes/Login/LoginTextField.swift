//
//  LoginTextField.swift
//  Traber
//
//  Created by luan on 2017/4/30.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            let right = UIImageView(image: rightImage)
            right.frame = CGRect(x: 0, y: 0, width: (rightImage?.size.width)! + 15, height: height)
            right.contentMode = .left
            rightView = right
            rightViewMode = .always
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
