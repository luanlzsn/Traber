//
//  MenuVC.swift
//  Traber
//
//  Created by luan on 2017/4/21.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class MenuVC: AntController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headPortraitBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    var isMessage = false
    
    var confirm : ConfirmBlock?
    
    let titleArray = ["Home", "Notifications", "My cases"/*,"Payment"*/, "Share", "Help", "Settings"/*, "More"*/]
    let imgArray = ["menu_home","menu_notifications","menu_cases"/*,"menu_payment"*/,"menu_share","menu_help","menu_setting"/*,"menu_more"*/]
    let identifierArray = ["","ShareCase","MyCases"/*,"Payment"*/,"Share","Help","Settings",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = AntManage.userModel!.firstname
        headPortraitBtn.sd_setImage(with: URL(string: AntManage.userModel!.image), for: .normal, placeholderImage: UIImage(named: "default_image"), options: .refreshCached)
        if AntManage.userModel!.identity.isEmpty {
            getUserInfo()
        }
    }
    
    func getUserInfo() {
        weak var weakSelf = self
        AntManage.postRequest(path: "user/info", params: ["identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token], successResult: { (response) in
            let token = AntManage.userModel!.token
            AntManage.userModel = UserModel.mj_object(withKeyValues: response)
            AntManage.userModel?.token = token
            weakSelf?.nameLabel.text = AntManage.userModel!.firstname
            weakSelf?.headPortraitBtn.sd_setImage(with: URL(string: AntManage.userModel!.image), for: .normal, placeholderImage: UIImage(named: "default_image"), options: .refreshCached)
        }, failureResult: {})
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if confirm != nil {
            confirm = nil
        }
    }
    
    func checkSelectMenu(confirmBlock: @escaping ConfirmBlock) {
        confirm = confirmBlock
    }

    @IBAction func headPortraitClick(_ sender: UIButton) {
        if confirm != nil {
            confirm!("EditProfile")
        }
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func termsAndConditionsClick(_ sender: UIButton) {
        if confirm != nil {
            confirm!("TermsConditions")
        }
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancelMenuClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MenuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.imgView.image = UIImage(named: imgArray[indexPath.row])
        cell.title.text = NSLocalizedString(titleArray[indexPath.row], comment: "")
        if indexPath.row == 1 {
            cell.greenView.isHidden = !isMessage
        } else {
            cell.greenView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath.row == titleArray.count - 1 {
//            AntManage.showDelayToast(message: NSLocalizedString("NO MORE", comment: ""))
//            return
//        }
        if indexPath.row == 3 {
            let url = "http://www.ticketez.com/FrontendWeb/home/?token=" + AntManage.userModel!.token + "&identity="
                + AntManage.userModel!.identity + "&redirecturl=refer&source=home&noheader=1"
            UIApplication.shared.openURL(URL(string: url)!)
        } else {
            if confirm != nil {
                confirm!(identifierArray[indexPath.row])
            }
        }
        
        dismiss(animated: false, completion: nil)
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
