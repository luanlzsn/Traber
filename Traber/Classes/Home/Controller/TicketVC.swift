//
//  TicketVC.swift
//  Traber
//
//  Created by luan on 2017/5/1.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class TicketVC: AntController {

    @IBOutlet weak var typeTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var unitNoLabel: UILabel!
    @IBOutlet weak var postCodeLabel: UILabel!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var dataDic: [String : String]!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if dataDic["Type"] == NSLocalizedString("Parking", comment: "") {
            typeTitle.text = NSLocalizedString("Parking Ticket", comment: "")
            nameTitle.text = NSLocalizedString("Car Owner's Name:", comment: "")
            addressTitle.text = NSLocalizedString("Car Owner's Address:", comment: "")
        } else {
            typeTitle.text = NSLocalizedString("Traffic Ticket", comment: "")
            nameTitle.text = NSLocalizedString("Driver’s License Name:", comment: "")
            addressTitle.text = NSLocalizedString("Driver’s License Address:", comment: "")
        }
        cityLabel.text = dataDic["City"]
        dateLabel.text = dataDic["Date"]
        unitNoLabel.text = dataDic["UnitNo"]
        postCodeLabel.text = dataDic["PostCode"]
        nameLabel.text = dataDic["Name"]
        addressLabel.text = dataDic["Address"]
        imgView.image = image
    }
    
    // MARK: 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LookPicture" {
            let lookPicture = segue.destination as! LookPictureVC
            lookPicture.imgArray = [image]
            lookPicture.currentPage  = 0
        } else if segue.identifier == "FileTicket" {
            let fileTicket = segue.destination as! FileTicketVC
            fileTicket.dataDic = dataDic
            fileTicket.image = image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
