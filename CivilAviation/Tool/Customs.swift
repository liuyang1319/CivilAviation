//
//  Customs.swift
//  SchoolChat_Parent_iOS
//
//  Created by Meteorshower on 2019/12/3.
//  Copyright © 2019 liuyang. All rights reserved.
//

import UIKit

class Customs: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let margin: CGFloat = 10
        let area = self.bounds.insetBy(dx: -margin, dy: -margin) //负值是方法响应范围
        return area.contains(point)
    }
}
