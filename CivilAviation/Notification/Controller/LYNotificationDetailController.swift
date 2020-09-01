//
//  LYNotificationDetailController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/30.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYNotificationDetailController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "通知详情", English: "Message details")
        tableView.removeFromSuperview()
    }

}
