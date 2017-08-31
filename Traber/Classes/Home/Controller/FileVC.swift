//
//  FileVC.swift
//  Traber
//
//  Created by luan on 2017/5/1.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class FileVC: AntController {

    @IBOutlet weak var btnOne: SpinnerButton!
    @IBOutlet weak var btnTwo: SpinnerButton!
    @IBOutlet weak var textField: UITextField!
    var dataDic: [String : String]!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkTextFieldLeftView(textField: textField)
    }

    @IBAction func buttonOneClick(_ sender: SpinnerButton) {
        sender.show(view: view, array: ["Yes","No"]) { (string) in
            sender.setTitle(string, for: .normal)
        }
    }
    
    @IBAction func buttonTwoClick(_ sender: SpinnerButton) {
        sender.show(view: view, array: ["I don't need interpreter","I need interpreter"]) { (string) in
            sender.setTitle(string, for: .normal)
        }
    }
    
    @IBAction func learnMoreClick(_ sender: UIButton) {
        
    }
    
    @IBAction func sendFormClick(_ sender: UIButton) {
        if btnOne.currentTitle == NSLocalizedString("Yes", comment: "") {
            dataDic["Evidence"] = "Yes"
        } else {
            dataDic["Evidence"] = "No"
        }
        dataDic["TrialLanguage"] = textField.text!
        if btnTwo.currentTitle == NSLocalizedString("I don't need interpreter", comment: "") {
            dataDic["Interpreter"] = "No"
        } else {
            dataDic["Interpreter"] = "Yes"
        }
        performSegue(withIdentifier: "InformationReview", sender: nil)
    }
    
    // MARK: - 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InformationReview" {
            let info = segue.destination as! InformationReviewVC
            info.dataDic = dataDic
            info.image = image
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
