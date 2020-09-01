//
//  LYExperienceSelectView.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/27.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

protocol LYExperienceSelectViewDelegate {
    func btnClicked(typeSelected: ExperienceType, experienceSelected: ExperienceSelect)
}

class LYExperienceSelectView: BaseSelectView {
    private let kBtnTag = 12271043
    
    @IBOutlet weak var maintenanceBack: UIView!
    @IBOutlet weak var trainBack: UIView!
    
    
    private var typeSelected: ExperienceType = .maintenance
    private var experienceSelected: ExperienceSelect = .first
    private let maintenanceTitleArray = [
        "维修经历\nMaintenance",
        "实习经历\nPractice",
        "更新经历\nUpdate",
        "其他经历\nOther"
    ]
    
    private let trainTitleArray = [
        "基础知识培训\nBasic training",
        "实作培训\nPractice training",
        "机型培训\nAircraft training"
    ]
    
    var delegate: LYExperienceSelectViewDelegate?
    
    @IBAction func btnClicked(_ sender: UIButton) {
        let tag = sender.tag - kBtnTag
        
        if !isRefreshType(tag: tag) {
            return
        }
        
        typeSelected = tag == 0 ? .maintenance : .train
        setTypeBtnState(sender: sender)
        resetTypeBtn()
        
        for index in 0 ..< getSelectBtnCount() {
            let label = getSelectLabel(index: index)
            label?.text = (typeSelected == .maintenance ? maintenanceTitleArray[index] : trainTitleArray[index])
        }
        selectBtnClicked(getSelectBtn(index: 0)!)
    }
    
    @IBAction func selectBtnClicked(_ sender: UIButton) {
        let tag = sender.tag - kBtnTag - 20
        if tag == 0 {
            experienceSelected = .first
        } else if tag == 1 {
            experienceSelected = .second
        } else if tag == 2 {
            experienceSelected = .third
        } else {
            experienceSelected = .four
        }
        
        setSelectBtnState(sender: sender)
        delegate?.btnClicked(typeSelected: typeSelected, experienceSelected: experienceSelected)
    }
    
    override func getBtnTag() -> Int {
        return kBtnTag
    }
    
    override func getSelectBtnCount() -> Int {
        return typeSelected == .maintenance ? 4 : 3
    }
    
    private func isRefreshType(tag: Int) -> Bool {
        if tag == 0 && typeSelected == .maintenance {
            return false
        }
        
        if tag == 1 && typeSelected == .train {
            return false
        }
        
        return true
    }
    
    private func resetTypeBtn() {
        maintenanceBack.isHidden = typeSelected != .maintenance
        trainBack.isHidden = !maintenanceBack.isHidden
    }
}
