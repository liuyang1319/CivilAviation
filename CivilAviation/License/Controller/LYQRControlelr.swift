//
//  LYQRControlelr.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYQRControlelr: BaseController {

    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var QRImage: UIImageView!
    
    var QR = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "执照二维码", English: "QR code")
        tableView.removeFromSuperview()
        QRImage.kf.setImage(with: URL.init(string: QR))
    }

}
