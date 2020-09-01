//
//  LYPersonalGradeCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/31.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYPersonalGradeCell: BaseCell {

    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValue(model: LYExamModel) {
        state.text = model.isPass + " " + model.isValid
        name.text = model.outName
        grade.text = model.score
        place.text = model.placeName
        time.text = model.time
    }
    
}
