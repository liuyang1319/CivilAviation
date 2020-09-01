//
//  LYExaminationController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/27.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYExaminationController: BaseController {

    private let kLYExaminationSelectView = "LYExaminationSelectView"
    private let kLYExaminationPlanCell = "LYExaminationPlanCell"
    private let kLYExaminationRegistrationCell = "LYExaminationRegistrationCell"
    
    private let registrationView = LYRegistrationView.instanceView(type: "LYRegistrationView") as! LYRegistrationView
    
    private var type: ExaminationType = .plan
    private var select: ExperienceSelect = .first
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "考试信息", English: "Examination information")
        tableView.register(
            UINib.init(nibName: kLYExaminationSelectView, bundle: nil),
            forHeaderFooterViewReuseIdentifier: kLYExaminationSelectView
        )
        cellArray = [
            kLYExaminationPlanCell,
            kLYExaminationRegistrationCell
        ]
        
        addTableViewHeader()
        addTableViewFootview()
        
        registrationView.delegate = self
        reFreshData()
    }

    override func initTableView() {
        super.initTableView()
        tableView.mj_h -= TabBarHeight
    }
    
    override func addLeftBtn() {}
    
    override func getData() {
        if type == .plan {
            getPlans(planName: "")
        } else {
            getPlanApplied(planName: "")
        }
    }
}

extension LYExaminationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return type == .plan ? 160 : 230
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == .plan {
            return getPlanCell(indexPath: indexPath)
        } else {
            return getRegistrationCell(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return type == .plan ? 200 : 130
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: kLYExaminationSelectView) as! LYExaminationSelectView
        view.setSearchDelegate()
        view.delegate = self
        return view
    }
    
    private func getPlanCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLYExaminationPlanCell) as! LYExaminationPlanCell
        cell.delegate = self
        if dataArray.count > indexPath.row {
            cell.setValue(model: dataArray[indexPath.row] as! LYExaminationPlanModel)
        }
        return cell
    }
    
    private func getRegistrationCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLYExaminationRegistrationCell) as! LYExaminationRegistrationCell
        if dataArray.count > indexPath.row {
            cell.setValue(model: dataArray[indexPath.row] as! LYExaminationPlanModel)
        }
        return cell
    }
}

extension LYExaminationController:
LYExaminationSelectViewDelegate,
LYExaminationPlanCellDelegate,
LYExaminationSubjectViewDelegate
{
    /// LYExaminationSelectViewDelegate
    func typeBtnClicked(type: ExaminationType) {
        self.type = type
        reFreshData()
    }
    
    func planBtnClicked(select: ExperienceSelect) {
        self.select = select
        registrationView.type = select
        reFreshData()
    }
    
    /// LYExaminationPlanCellDelegate
    func signUpBtnClicked(model: LYExaminationPlanModel) {
        if select == .first {   // 只有基础知识考试弹出选择页面
            registrationView.setValue(model: model)
            registrationView.appear()
            return
        }
        
        apply(id: model.id, major: "", items: [])
    }
    
    /// LYExaminationSubjectViewDelegate
    func subject(id: String, major: String, items: [String]) {
        apply(id: id, major: major, items: items)
    }
    
}

extension LYExaminationController {
    
    private func getPlans(planName: String) {
        LYExaminationViewModel.getPlains(
            type: select.rawValue,
            planName: planName,
            pageNum: nextPageFlag) { (datas, error) in
                if error != nil {
                    self.toastError(error: error!)
                    return
                }
                
                self.processData(datas: datas!, complate: {
                    self.dataArray += datas!
                    self.tableView.reloadData()
                })
                
        }
    }
    
    private func getPlanApplied(planName: String) {
        LYExaminationViewModel.getPlansApplied(
            planName: planName,
            pageNum: nextPageFlag) { (datas, error) in
                if error != nil {
                    self.toastError(error: error!)
                    return
                }
                
                self.processData(datas: datas!, complate: {
                    self.dataArray += datas!
                    self.tableView.reloadData()
                })
        }
    }
    
    func search(search: String) {
        dataArray = []
        nextPageFlag = 1
        if type == .plan {
            getPlans(planName: "")
        } else {
            getPlanApplied(planName: "")
        }
    }
    
    private func apply(id: String, major: String, items: [String]) {
        LYExaminationViewModel.apply(major: major, planId: id, items: items) { (error) in
            if error != nil {
                self.toastError(error: error!)
                return
            }
            
            for tmp in self.dataArray as! [LYExaminationPlanModel] {
                if tmp.id == id {
                    tmp.canApply = 1
                    tmp.status = "已报名"
                    break
                }
            }
            
            self.toast(toast: "报名成功")
            self.registrationView.disappear()
            self.tableView.reloadData()
        }
        
    }
    
}
