//
//  CALayer+XibConfiguration.swift
//  PartTime
//
//  Created by easyto on 2019/6/25.
//  Copyright © 2019年 liuyang. All rights reserved.
//

import UIKit

extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        
        get {
            return UIColor.init(cgColor: self.borderColor!)
        }
    }
    
    var shadowUIColor: UIColor {
        set {
            self.shadowColor = newValue.cgColor
        }
        
        get {
            return UIColor.init(cgColor: self.shadowColor!)
        }
    }
}
