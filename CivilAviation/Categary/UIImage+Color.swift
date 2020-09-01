//
//  UIImage+Color.swift
//  SchoolChat_Parent_iOS
//
//  Created by easyto on 2019/9/5.
//  Copyright © 2019 liuyang. All rights reserved.
//

import Foundation

extension UIImage {
    
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        return from(color: color, rect: rect)
    }
    
    static func from(color: UIColor, rect: CGRect) -> UIImage {
        return from(color: color, rect: rect, radius: 0)
    }
    
    static func from(color: UIColor, rect: CGRect, radius: CGFloat) -> UIImage {
        return UIImageView.init().from(color: color, rect: rect, radius: radius)
    }
}

extension UIImageView {
    func from(color: UIColor, rect: CGRect, radius: CGFloat) -> UIImage{
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
    
        let path = UIBezierPath.init(roundedRect: rect, cornerRadius: radius)
        path.addClip()
        draw(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
