//
//  LYExaminationSelectView.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/27.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

enum ExaminationType {
    case plan
    case registration
}

protocol LYExaminationSelectViewDelegate {
    func typeBtnClicked(type: ExaminationType)
    func planBtnClicked(select: ExperienceSelect)
    func search(search: String)
}

class LYExaminationSelectView: BaseSelectView {
    
    private var typeSelected: ExaminationType = .plan
    private var examinationSelected: ExperienceSelect = .first
    
    @IBOutlet weak var searchView: UITextField!
    @IBOutlet weak var selectBackView: UIView!
    
    private let kBtnTag = 122703557
    
    var delegate: LYExaminationSelectViewDelegate?
    
    func setSearchDelegate() {
        searchView.delegate = self
    }
    
    @IBAction func typeBtnClicked(_ sender: UIButton) {
        let tag = sender.tag - kBtnTag
        if tag == 0 {
            typeSelected = .plan
        } else {
            typeSelected = .registration
        }
        
        selectBackView.isHidden = tag == 1
        setTypeBtnState(sender: sender)
        delegate?.typeBtnClicked(type: typeSelected)
        searchView.endEditing(true)
        searchView.text = ""
    }
    
    @IBAction func examinationBtnClicked(_ sender: UIButton) {
        let tag = sender.tag - kBtnTag - 20
        if tag == 0 {
            examinationSelected = .first
        } else if tag == 1 {
            examinationSelected = .second
        } else {
            examinationSelected = .third
        }
        
        setSelectBtnState(sender: sender)
        delegate?.planBtnClicked(select: examinationSelected)
        searchView.endEditing(true)
        searchView.text = ""
    }
    
    override func getBtnTag() -> Int {
        return kBtnTag
    }
}

extension LYExaminationSelectView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        delegate?.search(search: textField.text ?? "")
        textField.endEditing(true)
        return true
    }
    
}
