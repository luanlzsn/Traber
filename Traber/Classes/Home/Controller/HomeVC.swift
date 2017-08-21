//
//  HomeVC.swift
//  Traber
//
//  Created by luan on 2017/4/21.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class HomeVC: AntController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var typeBtn: SpinnerButton!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var unitNo: UITextField!
    @IBOutlet weak var postCode: UITextField!
    @IBOutlet weak var addressField: UITextField!
    var isClear = true//是否清理数据
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem?.image = UIImage(named: "menu_icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        checkTextFieldLeftView(textField: cityField)
        checkCityTextFieldRightView()
        checkTextFieldLeftView(textField: unitNo)
        checkTextFieldLeftView(textField: postCode)
        checkTextFieldLeftView(textField: addressField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !AntManage.isLogin {
            let loginNav = UIStoryboard(name: "Login", bundle: Bundle.main).instantiateInitialViewController()
            present(loginNav!, animated: true, completion: nil)
        } else if AntManage.userModel!.identity.isEmpty {
            getUserInfo()
        }
        if isClear {
            typeBtn.setTitle("Ticket Type", for: .normal)
            cityField.text = ""
            dateBtn.setTitle("Infraction Date", for: .normal)
            unitNo.text = ""
            postCode.text = ""
            addressField.text = ""
        }
        isClear = true
    }
    
    func getUserInfo() {
        AntManage.postRequest(path: "user/info", params: ["source":"home", "identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token], successResult: { (response) in
            let token = AntManage.userModel!.token
            AntManage.userModel = UserModel.mj_object(withKeyValues: response)
            AntManage.userModel?.token = token
        }, failureResult: {})
    }
    
    @IBAction func typeClick(_ sender: SpinnerButton) {
        sender.show(view: view, array: ["Parking","Traffic violation"]) { (type) in
            sender.setTitle(type, for: .normal)
        }
    }
    
    @IBAction func photoClick(_ sender: UIButton) {
        if typeBtn.currentTitle == "Ticket Type" {
            AntManage.showDelayToast(message: "Please choose Ticket Type!")
            return
        }
        if dateBtn.currentTitle == "Infraction Date" {
            AntManage.showDelayToast(message: "Please choose Infraction Date!")
            return
        }
        if (unitNo.text?.isEmpty)! {
            AntManage.showDelayToast(message: "Unit No. is required!")
            return
        }
        if (addressField.text?.isEmpty)! {
            AntManage.showDelayToast(message: "Car owner's address is required!")
            return
        }
        if (cityField.text?.isEmpty)! {
            AntManage.showDelayToast(message: "Please choose City!")
            return
        }
        if (postCode.text?.isEmpty)! {
            AntManage.showDelayToast(message: "Post Code is required!")
            return
        }
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
        isClear = false
    }
    
    // MARK: 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Menu" {
            let menu = segue.destination as! MenuVC
            weak var weakSelf = self
            menu.checkSelectMenu(confirmBlock: { (identifier) in
                if !((identifier as! String).isEmpty) {
                    weakSelf?.perform(#selector(weakSelf!.performSegue(withIdentifier:sender:)), with: identifier as! String, afterDelay: 0.01)
                }
            })
        } else if segue.identifier == "InfractionDate" {
            let date = segue.destination as! InfractionDateVC
            weak var weakSelf = self
            date.checkInfractionDate(confirmBlock: { (dateStr) in
                weakSelf?.dateBtn.setTitle(dateStr as? String, for: .normal)
            })
        } else if segue.identifier == "Ticket" {
            let ticket = segue.destination as! TicketVC
            ticket.dataDic = ["Type":typeBtn.currentTitle!,"City":cityField.text!,"Date":dateBtn.currentTitle!,"UnitNo":unitNo.text!,"PostCode":postCode.text!,"Address":addressField.text!]
            ticket.image = sender as! UIImage
        }
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            let image = info[UIImagePickerControllerEditedImage]
            weakSelf?.performSegue(withIdentifier: "Ticket", sender: image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
        }
    }
    
    func checkTextFieldLeftView(textField: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.height))
        textField.leftView = leftView
        textField.leftViewMode = .always
    }
    
    func checkCityTextFieldRightView() {
        let rightView = UIImageView(image: UIImage(named: "location"))
        rightView.contentMode = .center
        rightView.frame = CGRect(x: 0, y: 0, width: 45, height: cityField.height)
        cityField.rightView = rightView
        cityField.rightViewMode = .always
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
