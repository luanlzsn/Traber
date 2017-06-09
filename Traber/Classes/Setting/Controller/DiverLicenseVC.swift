//
//  DiverLicenseVC.swift
//  Traber
//
//  Created by luan on 2017/4/30.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class DiverLicenseVC: AntController,UITableViewDelegate,UITableViewDataSource,EditProfile_Delegate {

    @IBOutlet weak var tableView: UITableView!
    let titleArray = ["Car Owner's Name","License Address","License City","License Province","License PostCode"]
    var detailArray = [AntManage.userModel!.licenseName,AntManage.userModel!.licenseAddress,AntManage.userModel!.licenseCity,AntManage.userModel!.licensePro,AntManage.userModel!.licensePostcode]
    var editIndexPath: IndexPath?
    weak var editProfile: EditProfileVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "EditProfileCell", bundle: Bundle.main), forCellReuseIdentifier: "EditProfileCell")
    }
    
    func checkFooterButtonClick(button: UIButton) {
        UIApplication.shared.keyWindow?.endEditing(true)
        var params = ["source":"home", "identity":UserDefaults.standard.object(forKey: kEmailKey)!, "token":AntManage.userModel!.token] as [String : Any]
        params["firstname"] = editProfile!.detailArray[0]
        params["lastname"] = editProfile!.detailArray[1]
        params["email"] = editProfile!.detailArray[2]
        params["phone"] = editProfile!.detailArray[3]
        if editProfile!.image != nil {
            params["image"] = "data:image/jpeg;base64," + UIImageJPEGRepresentation(editProfile!.image!, 0.1)!.base64EncodedString()
            params["imageType"] = "jpeg"
        }
        params["licenseName"] = detailArray[0]
        params["licenseAddress"] = detailArray[1]
        params["licenseCity"] = detailArray[2]
        params["licensePro"] = detailArray[3]
        params["licensePostcode"] = detailArray[4]
        
        weak var weakSelf = self
        AntManage.postRequest(path: "user/edit", params: params, successResult: { (response) in
            AntManage.showDelayToast(message: NSLocalizedString("update use info success", comment: ""))
            NotificationCenter.default.post(name: NSNotification.Name("UpdateInfoSuccess"), object: nil)
            weakSelf?.navigationController?.popViewController(animated: true)
        }, failureResult: {})
    }
    
    // MARK: EditProfile_Delegate
    func textFieldBeginEditing(indexPath: IndexPath) {
        editIndexPath = indexPath
    }
    
    func textFieldEndEditing(textField: UITextField, indexPath: IndexPath) {
        editIndexPath = nil
        detailArray.remove(at: indexPath.row)
        detailArray.insert(textField.text!, at: indexPath.row)
    }
    
    // MARK: UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 55))
        header.backgroundColor = UIColor.init(rgb: 0xf3f3f6)
        let sectionLabel = UILabel(frame: CGRect(x: 15, y: 30, width: kScreenWidth - 30, height: 25))
        sectionLabel.font = UIFont.systemFont(ofSize: 12)
        sectionLabel.textColor = UIColor.init(rgb: 0x6d6d72)
        sectionLabel.text = "Car Owner's Information"
        header.addSubview(sectionLabel)
        let lineView = UIView(frame: CGRect(x: 0, y: 54, width: kScreenWidth, height: 1))
        lineView.backgroundColor = UIColor.init(rgb: 0xc7c7cc)
        header.addSubview(lineView)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 15, y: 25, width: kScreenWidth - 30, height: 50)
        button.setTitle("Update Information", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = UIColor.init(rgb: 0x229d68)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 2.5
        button.tag = section
        button.addTarget(self, action: #selector(self.checkFooterButtonClick(button:)), for: .touchUpInside)
        footer.addSubview(button)
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EditProfileCell = tableView.dequeueReusableCell(withIdentifier: "EditProfileCell", for: indexPath) as! EditProfileCell
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.textField.placeholder = titleArray[indexPath.row]
        cell.textField.text = detailArray[indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
        cell.lineView.backgroundColor = (editIndexPath == indexPath) ? UIColor.init(rgb: 0x229d68) : UIColor.init(rgb: 0xc7c7cc)
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
