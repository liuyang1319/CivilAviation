//
//  LYExaminationRegistrationCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/27.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYExaminationRegistrationCell: BaseCell {

    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var stopDate: UILabel!
    @IBOutlet weak var quota: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValue(model: LYExaminationPlanModel) {
        state.text = model.status
        name.text = model.planName
        startDate.text = model.beginDate
        stopDate.text = model.endDate
        quota.text = "\(model.quota)"
    }
    
}
