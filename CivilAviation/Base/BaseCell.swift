//
//  BaseCell.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/19.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    var isDrawLine: Bool = false    //是否画横线
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none;
        
    }
    
    //    MARK: ---drawRect
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isDrawLine {
            let context: CGContext = UIGraphicsGetCurrentContext()!;
            context.setStrokeColor(UIColor.init(hex: 0xCBCBCB).cgColor);
            context.stroke(CGRect(x: 0, y: rect.height, width: rect.width, height: 0.5));
        }
        
    }

    func pushController(controller: UIViewController) {
        Tool.getNavigation().pushViewController(controller, animated: true)
    }
}
