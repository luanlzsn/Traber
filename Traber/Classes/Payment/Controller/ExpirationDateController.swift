//
//  ExpirationDateController.swift
//  Traber
//
//  Created by luan on 2017/9/12.
//  Copyright © 2017年 luan. All rights reserved.
//

import UIKit

class ExpirationDateController: AntController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var picketView: UIPickerView!
    let yearArray = ["2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030","2031","2032","2033","2034","2035"]
    let monthArray = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    var confirm : ConfirmBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelClick(_ sender: UIBarButtonItem) {
        confirm = nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmClick(_ sender: UIBarButtonItem) {
        if confirm != nil {
            confirm!(monthArray[picketView.selectedRow(inComponent: 1)] + "/" + yearArray[picketView.selectedRow(inComponent: 0)])
            confirm = nil
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIPickerViewDelegate,UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? yearArray.count : monthArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? yearArray[row] : monthArray[row]
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
