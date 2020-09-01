//
//  LYPersonalInfoCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/30.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYPersonalInfoCell: BaseCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var certificateId: UILabel!
    @IBOutlet weak var natiomality: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setValue(model: LYPersonModel?) {
        if model == nil {
            return
        }
        
        name.text = model?.name
        certificateId.text = model?.idNo
        natiomality.text = model?.nationality
        avatar.kf.setImage(with: URL(string: model!.headUrl))
    }

}
