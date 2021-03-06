//
//  SettingVC.swift
//  Traber
//
//  Created by luan on 2017/4/21.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class SettingVC: AntController,UITableViewDelegate,UITableViewDataSource,PushNotificationCell_Delegate {

    @IBOutlet weak var tableView: UITableView!
    let titleArray = ["Profile","Change password","Notification","Language","Logout"]
    let identifierArray = ["Profile","ChangePassword","","Language"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }
    
    // MARK: - PushNotificationCell_Delegate
    func switchChange(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: kIsOnNotification)
        UserDefaults.standard.synchronize()
        tableView.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("NotificationStatusChange"), object: nil)
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
        if indexPath.row == 2 {
            let cell: PushNotificationCell = tableView.dequeueReusableCell(withIdentifier: "PushNotificationCell", for: indexPath) as! PushNotificationCell
            cell.delegate = self
            cell.switchBtn.isOn = UserDefaults.standard.bool(forKey: kIsOnNotification)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = NSLocalizedString(titleArray[indexPath.row], comment: "")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 2 {
            
        } else if indexPath.row == 4 {
            ShareSDK.cancelAuthorize(SSDKPlatformType.typeFacebook)
            AntManage.isLogin = false
            AntManage.userModel = nil
            UserDefaults.standard.set(false, forKey: kIsRemember)
            UserDefaults.standard.set(false, forKey: kIsFacebook)
            UserDefaults.standard.removeObject(forKey: kFacebookUserInfo)
            UserDefaults.standard.removeObject(forKey: kEmailKey)
            UserDefaults.standard.removeObject(forKey: kPassWordKey)
            UserDefaults.standard.synchronize()
            _ = navigationController?.popToRootViewController(animated: true)
        } else {
            performSegue(withIdentifier: identifierArray[indexPath.row], sender: nil)
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
