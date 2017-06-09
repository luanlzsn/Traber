//
//  FileTicketCell.swift
//  Traber
//
//  Created by luan on 2017/5/1.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class FileTicketCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var explain: UILabel!
    @IBOutlet weak var button: UIButton!
    var ticketButtonClick: ConfirmBlock?
    
    deinit {
        if ticketButtonClick != nil {
            ticketButtonClick = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonClick(_ sender: UIButton) {
        if ticketButtonClick != nil {
            ticketButtonClick!(sender)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
