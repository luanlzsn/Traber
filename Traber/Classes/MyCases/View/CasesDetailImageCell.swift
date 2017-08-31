//
//  CasesDetailImageCell.swift
//  Traber
//
//  Created by luan on 2017/8/31.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class CasesDetailImageCell: UITableViewCell {

    @IBOutlet weak var caseNum: UILabel!
    @IBOutlet weak var caseImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
