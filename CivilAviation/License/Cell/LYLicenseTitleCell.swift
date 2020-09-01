//
//  LYLicenseTitleCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYLicenseTitleCell: BaseCell {

    @IBOutlet weak var noLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

   
    func setValue(noText: String) {
        noLabel.text = "执照编号：" + noText
    }
}
