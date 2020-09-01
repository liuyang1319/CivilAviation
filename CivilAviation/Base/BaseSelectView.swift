//
//  BaseSelectView.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/30.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class BaseSelectView: UITableViewHeaderFooterView {

    func setTypeBtnState(sender: UIButton) {
        for index in 0 ..< getTypeBtnCount() {
            let btn = getTypeBtn(index: index)
            btn?.isSelected = false
            
            let label = getTypeLabel(index: index)
            label?.textColor = UIColor.black
        }
        
        sender.isSelected = true
        let label = getTypeLabel(index: sender.tag - getBtnTag())
        label?.textColor = UIColor.white
    }
    
    func setSelectBtnState(sender: UIButton) {
        for index in 0 ..< getSelectBtnCount() {
            let btn = getSelectBtn(index: index)
            btn?.isSelected = false
            
            let label = getSelectLabel(index: index)
            label?.backgroundColor = UIColor.init(hex: 0x999999)
        }
        
        let label = getSelectLabel(index: sender.tag - getBtnTag() - 20)
        label?.backgroundColor = NavigationBackgroundColor
    }
    
    func getTypeBtn(index: Int) -> UIButton? {
        let btn = viewWithTag(getBtnTag() + index)
        if !(btn is UIButton) {
            return nil
        }
        
        return btn as? UIButton
    }
    
    func getTypeLabel(index: Int) -> UILabel? {
        let label = viewWithTag(getBtnTag() + 10 + index)
        if !(label is UILabel) {
            return nil
        }
        
        return label as? UILabel
    }
    
    func getSelectBtn(index: Int) -> UIButton? {
        let btn = viewWithTag(getBtnTag() + index + 20)
        if !(btn is UIButton) {
            return nil
        }
        
        return btn as? UIButton
    }
    
    func getSelectLabel(index: Int) -> UILabel? {
        let label = viewWithTag(getBtnTag() + 30 + index)
        if !(label is UILabel) {
            return nil
        }
        
        return label as? UILabel
    }
    
    func getTypeBtnCount() -> Int {
        return 2
    }
    
    func getSelectBtnCount() -> Int {
        return 3
    }
    
    func getBtnTag() -> Int {
        return 100
    }
}
