//
//  LYLicensePersonCardCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit
import Kingfisher

class LYLicensePersonCardCell: BaseCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var recordOdDishonesty: UILabel!
    @IBOutlet weak var licenseNo: UILabel!
    @IBOutlet weak var QRBtn: UIButton!
    
    private var QR = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.borderWidth = 1
        backView.layer.borderColor = NavigationBackgroundColor.cgColor
    }

    func setValue(model: LYLicenseModel?) {
        if model == nil {
            return
        }
        
        name.text = model?.name
        nationality.text = model?.nationality
//        recordOdDishonesty.text = model?.dishonesty
        licenseNo.text = model?.licenseNo
        avatar.kf.setImage(with: URL.init(string: model!.headUrl), placeholder: UIImage.init(named: "icon_personal_avatar_defaul"))
        self.QR = model!.licenseQrCode
        QRBtn.kf.setImage(with: URL.init(string: QR), for: .normal)
    }
    
//    func setValue(QR: String) {
//        if QR.length == 0 {
//            return
//        }
//        
//        self.QR = QR
//        
//        QRBtn.sd_setBackgroundImage(with: URL.init(string: QR),
//                                    for: .normal,
//                                    placeholderImage: UIImage.init(named: "QR"),
//                                    options: .avoidAutoSetImage,
//                                    context: nil)
//    }
    
    @IBAction func QRBtnClicked() {
        let controller = LYQRControlelr.init(nibName: "LYQRControlelr", bundle: nil)
        controller.QR = QR
        pushController(controller: controller)
    }
}
