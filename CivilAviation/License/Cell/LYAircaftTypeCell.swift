//
//  LYAircaftTypeCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

private enum AircaftTypeState {
    case effective
    case failure
}

class LYAircaftTypeCell: BaseCell {

    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var periodOfValidity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setState(state: .failure)
        isDrawLine = true
    }
    
    func setValue(model: LYPlaneTypeModel) {
        name.text = model.planName
        periodOfValidity.text = model.validBeginDate + "至" + model.validEndDate
        setState(state: model.status == "有效" ? .effective : .failure)
    }

    private func setState(state: AircaftTypeState) {
        self.state.text = (state == .effective ? "有效" : "失效")
        self.state.backgroundColor = (state == .effective ? NavigationBackgroundColor : UIColor.init(hex: 0x666666))
    }
}
