//
//  LYExaminationSubjectCell.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/19.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYExaminationSubjectCell: BaseCell {
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isDrawLine = true
    }
    
    func setValue(dic: [String : String]) {
        name.text = dic["name"]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = selected ? BackColor : UIColor.white
    }
    
}
