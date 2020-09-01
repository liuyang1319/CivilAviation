//
//  BaseView.swift
//  LipstickMachine
//
//  Created by easyto on 2019/3/2.
//  Copyright © 2019年 easyto. All rights reserved.
//

import UIKit

class BaseView: UIView {

    @objc public class func instanceView (type: String) -> BaseView{
        let myView = Bundle.main.loadNibNamed(type, owner: nil, options: nil)?.first
        return myView as! BaseView
    }
    
    @objc func appear() {
        let app: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let window: UIWindow = app.window!
        self.frame = kScreenBounds
        window.addSubview(self)
    }
    
    @objc func disappear() {
        if self.superview == nil {
            return
        }
        self.removeFromSuperview()
    }

}
