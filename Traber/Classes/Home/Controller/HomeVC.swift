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
    @IBOutlet weak var cityBtn: SpinnerButton!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var photoBtnTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem?.image = UIImage(named: "menu_icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        checkTextFieldLeftView(textField: nameField)
        checkTextFieldLeftView(textField: addressField)
        photoBtnTop.constant = -100
        nameField.isHidden = true
        addressField.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !AntManage.isLogin {
            let loginNav = UIStoryboard(name: "Login", bundle: Bundle.main).instantiateInitialViewController()
            present(loginNav!, animated: true, completion: nil)
        }
    }
    
    @IBAction func typeClick(_ sender: SpinnerButton) {
        weak var weakSelf = self
        sender.show(view: view, array: ["Parking","Traffic violation"]) { (type) in
            sender.setTitle(type, for: .normal)
            if type == "Parking" {
                weakSelf?.photoBtnTop.constant = 0
                weakSelf?.nameField.isHidden = false
                weakSelf?.addressField.isHidden = false
            } else {
                weakSelf?.photoBtnTop.constant = -100
                weakSelf?.nameField.isHidden = true
                weakSelf?.addressField.isHidden = true
            }
        }
    }
    
    @IBAction func cityClick(_ sender: SpinnerButton) {
        sender.show(view: view, array: ["East Cydney","East Myrnafurt","New Tavaresland","East Enola","Lake Destin"]) { (address) in
            sender.setTitle(address, for: .normal)
        }
    }
    
    @IBAction func photoClick(_ sender: UIButton) {
        if typeBtn.currentTitle == "Ticket Type" {
            AntManage.showDelayToast(message: "Please choose Ticket Type!")
            return
        }
        if cityBtn.currentTitle == "City" {
            AntManage.showDelayToast(message: "Please choose City!")
            return
        }
        if dateBtn.currentTitle == "Infraction Date" {
            AntManage.showDelayToast(message: "Please choose Infraction Date!")
            return
        }
        if typeBtn.currentTitle == "Parking" {
            if (nameField.text?.isEmpty)! {
                AntManage.showDelayToast(message: "Car owenr's name is required!")
                return
            }
            if (nameField.text?.isEmpty)! {
                AntManage.showDelayToast(message: "Car owenr's address is required!")
                return
            }
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
    }
    
    // MARK: 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Menu" {
            let menu = segue.destination as! MenuVC
            weak var weakSelf = self
            menu.checkSelectMenu(confirmBlock: { (identifier) in
                if !((identifier as! String).isEmpty) {
                    weakSelf?.performSegue(withIdentifier: identifier as! String, sender: weakSelf)
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
            ticket.dataDic = ["Type":typeBtn.currentTitle!,"City":cityBtn.currentTitle!,"Date":dateBtn.currentTitle!,"Name":nameField.text!,"Address":addressField.text!]
            ticket.imageArray.append(sender as! UIImage)
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
