//
//  LYPersonalSubmitView.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/31.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

protocol LYPersonalSubmitViewDelegate {
    func submitBtnClicked()
}

class LYPersonalSubmitView: BaseView {

    var delegate: LYPersonalSubmitViewDelegate?
    
    @IBAction func btnClicked() {
        delegate?.submitBtnClicked()
    }
    
}
