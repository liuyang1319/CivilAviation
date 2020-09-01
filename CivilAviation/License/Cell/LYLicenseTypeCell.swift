//
//  LYLicenseTypeCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYLicenseTypeCell: BaseCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isDrawLine = true
    }

    func setValue(model: LYLicenseTypeModel) {
        name.text = model.licenseTypeName
        date.text = model.englishLevel
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
