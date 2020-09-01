//
//  LYPersonalItemCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/30.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYPersonalItemCell: BaseCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setValue(icon: String, title: String) {
        self.icon.image = UIImage.init(named: icon)
        self.titlelabel.text = title
    }
}
