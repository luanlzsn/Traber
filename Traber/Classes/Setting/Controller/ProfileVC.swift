//
//  ProfileVC.swift
//  Traber
//
//  Created by luan on 2017/4/30.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class ProfileVC: AntController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    let sectionTitleArray = ["", "Car Owner's Information", "Personal Information"]
    let titleArray = [["First Name", "Last Name", "E-mail", "Phone", "Store credit"],["Name", "Address", "City","Country", "Province", "Postcode"],["Address", "City", "Country", "Province"]]
    var detailArray = [[AntManage.userModel!.firstname,AntManage.userModel!.lastname,AntManage.userModel!.email,AntManage.userModel!.phone,"$\(AntManage.userModel!.store_credit)"],[AntManage.userModel!.licenseName,AntManage.userModel!.licenseAddress,AntManage.userModel!.licenseCity,AntManage.userModel!.licenseCountry,AntManage.userModel!.licensePro,AntManage.userModel!.licensePostcode],[AntManage.userModel!.address,AntManage.userModel!.city,AntManage.userModel!.country,AntManage.userModel!.province]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        detailArray = [[AntManage.userModel!.firstname,AntManage.userModel!.lastname,AntManage.userModel!.email,AntManage.userModel!.phone,"$\(AntManage.userModel!.store_credit)"],[AntManage.userModel!.licenseName,AntManage.userModel!.licenseAddress,AntManage.userModel!.licenseCity,AntManage.userModel!.licenseCountry,AntManage.userModel!.licensePro,AntManage.userModel!.licensePostcode],[AntManage.userModel!.address,AntManage.userModel!.city,AntManage.userModel!.country,AntManage.userModel!.province]]
        nameLabel.text = AntManage.userModel!.firstname + " " + AntManage.userModel!.lastname
        imgView.sd_setImage(with: URL(string: AntManage.userModel!.image))
        tableView.reloadData()
    }
    
    // MARK: UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 55
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == sectionTitleArray.count - 1 ? 20 : 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 55))
        let sectionLabel = UILabel(frame: CGRect(x: 15, y: 30, width: kScreenWidth - 30, height: 25))
        sectionLabel.font = UIFont.systemFont(ofSize: 12)
        sectionLabel.textColor = UIColor.init(rgb: 0x6d6d72)
        sectionLabel.text = NSLocalizedString(sectionTitleArray[section], comment: "")
        header.addSubview(sectionLabel)
        let lineView = UIView(frame: CGRect(x: 0, y: 54, width: kScreenWidth, height: 1))
        lineView.backgroundColor = UIColor.init(rgb: 0xc7c7cc)
        header.addSubview(lineView)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.titleLabel.text = NSLocalizedString(titleArray[indexPath.section][indexPath.row], comment: "") + ":"
        cell.detailLabel.text = detailArray[indexPath.section][indexPath.row]
        return cell
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
