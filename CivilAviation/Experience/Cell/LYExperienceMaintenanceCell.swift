//
//  LYExperienceMaintenanceCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/27.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYExperienceMaintenanceCell: BaseCell {

    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var aircraft: UILabel!
    @IBOutlet weak var certifier: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var jobContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValue(model: LYMaintenanceModel) {
        state.text = model.status
        type.text = model.type
        aircraft.text = model.planeTypes
        certifier.text = model.certifier
        duration.text = model.beginDate + "至" + model.endDate
        jobContent.text = model.jobContent
    }
    
}
