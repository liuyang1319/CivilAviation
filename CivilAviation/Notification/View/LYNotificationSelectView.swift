//
//  LYNotificationSelectView.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/30.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

enum NotificationType {
    case unRead
    case readed
}

protocol LYNotificationSelectViewDelegate {
    func typeBtnClicked(type: NotificationType)
}

class LYNotificationSelectView: BaseSelectView {
    
    private let kBtnTag = 1230150
    private var typeSelected: NotificationType = .unRead
    
    var delegate: LYNotificationSelectViewDelegate?
    
    @IBAction func btnClicked(_ sender: UIButton) {
        let tag = sender.tag - kBtnTag
        if tag == 0 {
            typeSelected = .unRead
        } else {
            typeSelected = .readed
        }
        
        setTypeBtnState(sender: sender)
        delegate?.typeBtnClicked(type: typeSelected)
    }

    override func getBtnTag() -> Int {
        return kBtnTag
    }
}
