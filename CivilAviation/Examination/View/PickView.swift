//
//  PickView.swift
//  PartTime
//
//  Created by easyto on 2019/6/26.
//  Copyright © 2019年 liuyang. All rights reserved.
//

import UIKit

protocol PickViewDelegate {
    func pickDidSelected(selectedIndex: Int, selectedTitle: String)
}

class PickView: BaseView, UIPickerViewDataSource, UIPickerViewDelegate {

    var delegate: PickViewDelegate?
    fileprivate var dataArray: [String] = []
    fileprivate var selectedIndex : Int = 0
    fileprivate var selectedTitle : String = ""
    
    @IBOutlet weak var pick: UIPickerView!

    public static func instanceView () -> PickView{
        let myView: PickView = super.instanceView(type: "PickView") as! PickView
        myView.pick.delegate = myView
        myView.pick.dataSource = myView
        return myView 
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
        selectedTitle = dataArray.count > 0 ? dataArray[row] : ""
    }
    
    func setData(data: [String]) {
        dataArray = data
        selectedIndex = 0
        selectedTitle = dataArray.first ?? ""
        pick.reloadAllComponents()
        pick.selectRow(selectedIndex, inComponent: 0, animated: true)
    }

    @IBAction func selected() {
        delegate?.pickDidSelected(selectedIndex: selectedIndex, selectedTitle:selectedTitle)
        self.disappear()
    }
}

