//
//  LYPersonalDishonestyQRCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/31.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYPersonalDishonestyQRCell: BaseCell {

    @IBOutlet weak var dishonesty: UILabel!
    @IBOutlet weak var QR: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValue(model: LYDishonestysModel?) {
        dishonesty.text = model?.dishonesty
        QR.kf.setImage(with: URL.init(string: model?.qrCode ?? ""))
    }
    
}
