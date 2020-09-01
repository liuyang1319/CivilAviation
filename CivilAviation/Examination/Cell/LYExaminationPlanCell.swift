//
//  LYExaminationPlanCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/27.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

protocol LYExaminationPlanCellDelegate {
    func signUpBtnClicked(model: LYExaminationPlanModel)
}

class LYExaminationPlanCell: BaseCell {

    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var delegate: LYExaminationPlanCellDelegate?
    private var model: LYExaminationPlanModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setValue(model: LYExaminationPlanModel) {
        self.model = model
        state.text = model.status
        name.text = model.planName
        date.text = model.beginDate + "至" + model.endDate
        count.text = "\(model.quota)"
        setSignUpState(state: model.canApply)
    }

    private func setSignUpState(state: Int) {
        signUpBtn.isUserInteractionEnabled = state == 0
        signUpBtn.backgroundColor = state == 0 ? NavigationBackgroundColor : TextColor
    }
    
    @IBAction func signUpBtnClicked() {
        if model == nil {
            return
        }
        
        delegate?.signUpBtnClicked(model: model!)
    }
    
}
