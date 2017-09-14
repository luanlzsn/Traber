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
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    var isClear = true//是否清理数据
    var statusTimer: Timer?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(cancelTimer), name: NSNotification.Name("SwitchLanguage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkTimer), name: NSNotification.Name("NotificationStatusChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getUserInfo), name: NSNotification.Name("PaySuccess"), object: nil)
        if UserDefaults.standard.bool(forKey: kIsOnNotification) {
            statusTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(checkChatStatus), userInfo: nil, repeats: true)
        }
        navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "menu_icon_white")
        
        checkTextFieldLeftView(textField: cityField)
        checkCityTextFieldRightView()
        checkTextFieldLeftView(textField: unitNo)
        checkTextFieldLeftView(textField: postCode)
        checkTextFieldLeftView(textField: nameField)
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
            typeBtn.setTitle(NSLocalizedString("Ticket Type", comment: ""), for: .normal)
            cityField.text = ""
            dateBtn.setTitle(NSLocalizedString("Infraction Date", comment: ""), for: .normal)
            unitNo.text = ""
            postCode.text = ""
            nameField.text = ""
            addressField.text = ""
            nameField.placeholder = NSLocalizedString("Car Owner's Name:", comment: "")
            addressField.placeholder = NSLocalizedString("Car Owner's Address:", comment: "")
        }
        isClear = true
    }
    
    // MARK: - 获取chat状态
    func checkChatStatus() {
        if AntManage.isLogin {
            weak var weakSelf = self
            AntManage.postRequest(path: "chat/status", params: ["identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token], successResult: { (response) in
                let hasTicketChat = response["hasTicketChat"] as! Bool
                let hasUserChat = response["hasUserChat"] as! Bool
                if hasTicketChat || hasUserChat {
                    weakSelf?.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "menu_icon").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                } else {
                    weakSelf?.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "menu_icon_white")
                }
            }, failureResult: {})
        }
    }
    
    func cancelTimer() {
        statusTimer?.invalidate()
        statusTimer = nil
    }
    
    func checkTimer() {
        if UserDefaults.standard.bool(forKey: kIsOnNotification) {
            if statusTimer == nil {
                statusTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(checkChatStatus), userInfo: nil, repeats: true)
            }
        } else {
            cancelTimer()
        }
    }
    
    func getUserInfo() {
        AntManage.postRequest(path: "user/info", params: ["identity":(UserDefaults.standard.object(forKey: kEmailKey) as! String), "token":AntManage.userModel!.token], successResult: { (response) in
            let token = AntManage.userModel!.token
            AntManage.userModel = UserModel.mj_object(withKeyValues: response)
            AntManage.userModel?.token = token
        }, failureResult: {})
    }
    
    @IBAction func typeClick(_ sender: SpinnerButton) {
        weak var weakSelf = self
        sender.show(view: view, array: ["Parking", "Traffic Violation"]) { (type) in
            sender.setTitle(type, for: .normal)
            if type == NSLocalizedString("Parking", comment: "") {
                weakSelf?.nameField.placeholder = NSLocalizedString("Car Owner's Name:", comment: "")
                weakSelf?.addressField.placeholder = NSLocalizedString("Car Owner's Address:", comment: "")
            } else {
                weakSelf?.nameField.placeholder = NSLocalizedString("Driver’s License Name:", comment: "")
                weakSelf?.addressField.placeholder = NSLocalizedString("Driver’s License Address:", comment: "")
            }
        }
    }
    
    @IBAction func photoClick(_ sender: UIButton) {
        if typeBtn.currentTitle == NSLocalizedString("Ticket Type", comment: "") {
            AntManage.showDelayToast(message: NSLocalizedString("Please choose Ticket Type", comment: ""))
            return
        }
        if dateBtn.currentTitle == NSLocalizedString("Infraction Date", comment: "") {
            AntManage.showDelayToast(message: NSLocalizedString("Infraction Date is required", comment: ""))
            return
        }
        if (nameField.text?.isEmpty)! {
            if typeBtn.currentTitle == NSLocalizedString("Parking", comment: "") {
                AntManage.showDelayToast(message: NSLocalizedString("Car Owner's Name is required", comment: ""))
            } else {
                AntManage.showDelayToast(message: NSLocalizedString("Driver’s License Name is required", comment: ""))
            }
            return
        }
        if (addressField.text?.isEmpty)! {
            if typeBtn.currentTitle == NSLocalizedString("Parking", comment: "") {
                AntManage.showDelayToast(message: NSLocalizedString("Car Owner's Address is required", comment: ""))
            } else {
                AntManage.showDelayToast(message: NSLocalizedString("Driver’s License Address is required", comment: ""))
            }
            return
        }
        if (unitNo.text?.isEmpty)! {
            AntManage.showDelayToast(message: NSLocalizedString("Unit Number is required", comment: ""))
            return
        }
        if (cityField.text?.isEmpty)! {
            AntManage.showDelayToast(message: NSLocalizedString("City is required", comment: ""))
            return
        }
        if (postCode.text?.isEmpty)! {
            AntManage.showDelayToast(message: NSLocalizedString("Post Code is required", comment: ""))
            return
        }
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
            menu.isMessage = !(navigationItem.leftBarButtonItem?.image == #imageLiteral(resourceName: "menu_icon_white"))
            weak var weakSelf = self
            menu.checkSelectMenu(confirmBlock: { (identifier) in
                if !((identifier as! String).isEmpty) {
//                    weakSelf?.perform(#selector(weakSelf!.performSegue(withIdentifier:sender:)), with: identifier as! String, afterDelay: 0.01)
                    weakSelf?.perform(#selector(weakSelf!.pushController(_:)), with: identifier, afterDelay: 0.01)
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
            ticket.dataDic = ["Type":((typeBtn.currentTitle == NSLocalizedString("Parking", comment: "")) ? "Parking" : "Traffic Violation"), "City":cityField.text!, "Date":dateBtn.currentTitle!, "UnitNo":unitNo.text!, "PostCode":postCode.text!, "Name":nameField.text!, "Address":addressField.text!]
            ticket.image = sender as! UIImage
        }
    }
    
    func pushController(_ identifier: String) {
        performSegue(withIdentifier: identifier, sender: nil)
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
