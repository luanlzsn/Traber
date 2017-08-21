//
//  InfractionDateVC.swift
//  Traber
//
//  Created by luan on 2017/5/1.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class InfractionDateVC: AntController {

    @IBOutlet weak var datePicker: UIDatePicker!
    var confirm : ConfirmBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.maximumDate = Date.init()
    }
    
    func checkInfractionDate(confirmBlock: @escaping ConfirmBlock) {
        confirm = confirmBlock
    }

    @IBAction func cancelClick(_ sender: UIBarButtonItem) {
        confirm = nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmClick(_ sender: UIBarButtonItem) {
        if confirm != nil {
            confirm!(Common.obtainStringWithDate(date: datePicker.date, formatterStr: "yyyy/MM/dd"))
            confirm = nil
        }
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
