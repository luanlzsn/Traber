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
    
    let titleArray = ["Home","Notifications","My cases","Payment","Share","Help","Settings","More"]
    let imgArray = ["menu_home","menu_notifications","menu_cases","menu_payment","menu_share","menu_help","menu_setting","menu_more"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headPortraitBtn.sd_setImage(with: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492764217372&di=d31292ce1c8c20348b6bb22a3d87323e&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201509%2F10%2F20150910225146_hFfnK.thumb.224_0.jpeg"), for: .normal)
    }

    @IBAction func headPortraitClick(_ sender: UIButton) {
        
    }
    
    @IBAction func termsAndConditionsClick(_ sender: UIButton) {
        
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
        cell.title.text = titleArray[indexPath.row]
        if indexPath.row == 1 {
            cell.number.isHidden = false
        } else {
            cell.number.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
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
