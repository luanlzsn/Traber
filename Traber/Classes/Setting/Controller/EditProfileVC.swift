//
//  EditProfileVC.swift
//  Traber
//
//  Created by luan on 2017/4/30.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class EditProfileVC: AntController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,EditProfile_Delegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    let titleArray = ["First Name", "Last Name", "E-mail", "Phone"]
    var detailArray = [AntManage.userModel!.firstname,AntManage.userModel!.lastname,AntManage.userModel!.email,AntManage.userModel!.phone]
    var editRow = -1
    var image: UIImage?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(getUserInfo), name: NSNotification.Name("UpdateInfoSuccess"), object: nil)
        tableView.register(UINib(nibName: "EditProfileCell", bundle: Bundle.main), forCellReuseIdentifier: "EditProfileCell")
        nameLabel.text = AntManage.userModel!.firstname + " " + AntManage.userModel!.lastname
        imgView.sd_setImage(with: URL(string: AntManage.userModel!.image), placeholderImage: UIImage(named: "default_image"), options: .refreshCached)
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.choosePhotoClick)))
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
            weakSelf?.nameLabel.text = AntManage.userModel!.firstname + " " + AntManage.userModel!.lastname
            weakSelf?.imgView.sd_setImage(with: URL(string: AntManage.userModel!.image), placeholderImage: UIImage(named: "default_image"), options: .refreshCached)
            weakSelf?.detailArray = [AntManage.userModel!.firstname,AntManage.userModel!.lastname,AntManage.userModel!.email,AntManage.userModel!.phone]
            weakSelf?.tableView.reloadData()
        }, failureResult: {
            weakSelf?.navigationController?.popViewController(animated: true)
        })
    }
    
    func checkFooterButtonClick(button: UIButton) {
        kWindow?.endEditing(true)
        if !detailArray[2].isEmpty, !Common.isValidateEmail(email: detailArray[2]) {
            AntManage.showDelayToast(message: NSLocalizedString("Invalid email", comment: ""))
            return
        }
        var params = ["identity":UserDefaults.standard.object(forKey: kEmailKey)!, "token":AntManage.userModel!.token] as [String : Any]
        params["firstname"] = detailArray[0]
        params["lastname"] = detailArray[1]
        params["email"] = detailArray[2]
        params["phone"] = detailArray[3]
        if image != nil {
            params["image"] = "data:image/jpeg;base64," + UIImageJPEGRepresentation(image!, 0.1)!.base64EncodedString()
            params["imageType"] = "jpeg"
        }
        
        AntManage.postRequest(path: "user/edit", params: params, successResult: { (response) in
            NotificationCenter.default.post(name: NSNotification.Name("UpdateInfoSuccess"), object: nil)
        }, failureResult: {})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DiverLicense" {
            let diver = segue.destination as! DiverLicenseVC
            diver.editProfile = self
        }
    }
    
    func choosePhotoClick() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        weak var weakSelf = self
        sheet.addAction(UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: { (_) in
            weakSelf?.takingPictures(sourceType: .camera)
        }))
        sheet.addAction(UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default, handler: { (_) in
            weakSelf?.takingPictures(sourceType: .photoLibrary)
        }))
        sheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        navigationController?.present(sheet, animated: true, completion: nil)
    }
    
    func takingPictures(sourceType: UIImagePickerControllerSourceType) {
        if sourceType == .camera {
            if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
                let alert = UIAlertController(title: NSLocalizedString("Reminder", comment: ""), message: NSLocalizedString("Your device does not have a camera", comment: ""), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: .cancel, handler: nil))
                navigationController?.present(alert, animated: true, completion: nil)
                return;
            }
        }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = sourceType
        navigationController?.present(picker, animated: true, completion: nil)
    }
    
    // MARK: EditProfile_Delegate
    func textFieldBeginEditing(indexPath: IndexPath) {
        editRow = indexPath.row
    }
    
    func textFieldEndEditing(textField: UITextField, indexPath: IndexPath) {
        detailArray.remove(at: indexPath.row)
        detailArray.insert(textField.text!, at: indexPath.row)
        editRow = -1
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            let image = info[UIImagePickerControllerEditedImage]
            weakSelf?.imgView.image = image as? UIImage
            weakSelf?.image = image as? UIImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
        }
    }
    
    // MARK: UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? titleArray.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 80 : 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 25 : 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 25))
            let line = UIView(frame: CGRect(x: 0, y: 24, width: kScreenWidth, height: 1))
            line.backgroundColor = UIColor.init(rgb: 0xc7c7cc)
            footer.addSubview(line)
            return footer
        } else {
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 15, y: 25, width: kScreenWidth - 30, height: 50)
            button.setTitle(NSLocalizedString("Update Information", comment: ""), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.backgroundColor = UIColor.init(rgb: 0x229d68)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 2.5
            button.tag = section
            button.addTarget(self, action: #selector(self.checkFooterButtonClick(button:)), for: .touchUpInside)
            footer.addSubview(button)
            return footer
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: EditProfileCell = tableView.dequeueReusableCell(withIdentifier: "EditProfileCell", for: indexPath) as! EditProfileCell
            cell.titleLabel.text = NSLocalizedString(titleArray[indexPath.row], comment: "")
            cell.textField.placeholder = NSLocalizedString(titleArray[indexPath.row], comment: "")
            cell.textField.text = detailArray[indexPath.row]
            cell.indexPath = indexPath
            cell.delegate = self
            cell.lineView.backgroundColor = (editRow == indexPath.row) ? UIColor.init(rgb: 0x229d68) : UIColor.init(rgb: 0xc7c7cc)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        kWindow?.endEditing(true)
        if indexPath.section == 1 {
            if !detailArray[2].isEmpty, !Common.isValidateEmail(email: detailArray[2]) {
                AntManage.showDelayToast(message: NSLocalizedString("Invalid email", comment: ""))
            } else {
                performSegue(withIdentifier: "DiverLicense", sender: nil)
            }
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
