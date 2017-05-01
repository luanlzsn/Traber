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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkTextFieldLeftView(textField: textField)
    }

    @IBAction func buttonOneClick(_ sender: SpinnerButton) {
        sender.show(view: view, array: ["Choice A","Choice B","Choice C"]) { (string) in
            sender.setTitle(string, for: .normal)
        }
    }
    
    @IBAction func buttonTwoClick(_ sender: SpinnerButton) {
        sender.show(view: view, array: ["Language A","Language B","Language C"]) { (string) in
            sender.setTitle(string, for: .normal)
        }
    }
    
    @IBAction func learnMoreClick(_ sender: UIButton) {
        
    }
    
    @IBAction func sendFormClick(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
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
