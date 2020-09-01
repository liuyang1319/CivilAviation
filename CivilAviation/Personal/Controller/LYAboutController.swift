//
//  LYAboutController.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/19.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYAboutController: BaseController {

    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var latest: UILabel!
    
    @IBOutlet weak var top: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        top.constant = StatusBarAndNavHeight + 80
        tableView.removeFromSuperview()
        setTitle(title: "关于", English: "About")
        current.text = "当前版本/Current Version：" + DeviceTool.getAppVersion()
        LYPersonViewModel.getLatest { (appVersion) in
            self.latest.text = "最新版本/Latest Version：" + appVersion
        }
    }
}
