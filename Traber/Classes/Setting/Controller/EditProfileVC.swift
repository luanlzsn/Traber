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
    let titleArray = ["First Name","Last Name","E-mail","Photo"]
    var detailArray = ["","","",""]
    var editRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "EditProfileCell", bundle: Bundle.main), forCellReuseIdentifier: "EditProfileCell")
        imgView.sd_setImage(with: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492764217372&di=d31292ce1c8c20348b6bb22a3d87323e&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201509%2F10%2F20150910225146_hFfnK.thumb.224_0.jpeg"))
    }

    @IBAction func choosePhotoClick(_ sender: UIButton) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        weak var weakSelf = self
        sheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            weakSelf?.takingPictures(sourceType: .camera)
        }))
        sheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (_) in
            weakSelf?.takingPictures(sourceType: .photoLibrary)
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        navigationController?.present(sheet, animated: true, completion: nil)
    }
    
    func takingPictures(sourceType: UIImagePickerControllerSourceType) {
        if sourceType == .camera {
            if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
                let alert = UIAlertController(title: "Reminder", message: "Your device does not have a camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "YES", style: .cancel, handler: nil))
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
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footer = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 25))
            let line = UIView(frame: CGRect(x: 0, y: 24, width: kScreenWidth, height: 1))
            line.backgroundColor = UIColor.init(rgb: 0xc7c7cc)
            footer.addSubview(line)
            return footer
        } else {
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: EditProfileCell = tableView.dequeueReusableCell(withIdentifier: "EditProfileCell", for: indexPath) as! EditProfileCell
            cell.titleLabel.text = titleArray[indexPath.row]
            cell.textField.placeholder = titleArray[indexPath.row]
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
        if indexPath.section == 1 {
            performSegue(withIdentifier: "DiverLicense", sender: nil)
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
