//
//  LYRegistrationView.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/19.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYRegistrationView: BaseView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var registrationDate: UILabel!
    @IBOutlet weak var exmaminationDate: UILabel!
    
    private let subjectView = LYExaminationSubjectView.instance()
    
    private var model: LYExaminationPlanModel?
    var type: ExperienceSelect = .first
    var delegate: LYExaminationSubjectViewDelegate?
    
    func setValue(model: LYExaminationPlanModel) {
        self.model = model
        title.text = model.planName
        registrationDate.text = model.beginDate + "至" + model.endDate
        subjectView.delegate = self.delegate
    }
    
    override func disappear() {
        subjectView.disappear()
        super.disappear()
    }
    
    @IBAction func dismissBtnClicked() {
        disappear()
    }
    
    @IBAction func registrationBtnClicked() {
        LYExaminationViewModel.getItems(type: type.rawValue) { (result, error) in
            if error != nil || result == nil {
                CBToast.showToastAction(message: ((error as NSError?)?.domain ?? "未知错误") as NSString)
                return
            }
            
            self.subjectView.setData(datas: result!)
            self.subjectView.id = self.model?.id ?? ""
            self.subjectView.appear()
        }
    }
}
