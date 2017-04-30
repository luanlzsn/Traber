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
    let sectionTitleArray = ["","Car Owner's Information","Personal Information"]
    let titleArray = [["First Name:","Last Name:","E-mail:","Phone:","Store credit:"],["Name:","Address:","City:","Country:","Province:","Postcode:"],["Address:","City:","Country:","Province:"]]
    let detailArray = [["Shawn","Barret","barret@gmail.com","707-674-0029","$0.00"],["Name","Address","City","Country","Province","Postcode"],["2370 Davis Avenue","San Jose","USA","Province Name"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgView.sd_setImage(with: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492764217372&di=d31292ce1c8c20348b6bb22a3d87323e&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201509%2F10%2F20150910225146_hFfnK.thumb.224_0.jpeg"))
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
        sectionLabel.text = sectionTitleArray[section]
        header.addSubview(sectionLabel)
        let lineView = UIView(frame: CGRect(x: 0, y: 54, width: kScreenWidth, height: 1))
        lineView.backgroundColor = UIColor.init(rgb: 0xc7c7cc)
        header.addSubview(lineView)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.titleLabel.text = titleArray[indexPath.section][indexPath.row]
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
