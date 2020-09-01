//
//  LYNotificationCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/30.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYNotificationCell: BaseCell {

    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var notificationTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValue(model: LYNotificationModel) {
        state.text = model.MSG_TYPE
        notificationTitle.text = model.TITLE
    }
    
}
