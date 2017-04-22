//
//  MyCasesCell.swift
//  Traber
//
//  Created by luan on 2017/4/21.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class MyCasesCell: UITableViewCell {

    @IBOutlet weak var caseNum: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var infractionDate: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var fileDate: UILabel!
    @IBOutlet weak var courtDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
