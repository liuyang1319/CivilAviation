//
//  LYPersonalDishonestyInfoCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/31.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYPersonalDishonestyInfoCell: BaseCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var certificateId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValue(model: LYPersonModel?) {
        if model == nil {
            return
        }
        
        name.text = model?.name
        certificateId.text = model?.idNo
    }
    
}
