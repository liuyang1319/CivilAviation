//
//  UIImage+Compound.swift
//  SchoolChat_Parent_iOS
//
//  Created by Meteorshower on 2019/12/4.
//  Copyright © 2019 liuyang. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 合成图片
    ///
    /// - Parameters:
    ///   - bgImage: 背景图片
    ///   - bgSize:  背景大小
    ///   - iconImage: 头像
    /// - Returns: 返回新图片
    class func createImage(bgImage: UIImage, bgSize: CGSize, iconImage: UIImage?, iconSize: CGSize, radius: CGFloat) -> UIImage {
        // 1.开启图片上下文
        UIGraphicsBeginImageContext(bgSize)
        // 根据矩形画带圆角的曲线
        let bezierPath = UIBezierPath.init(roundedRect: CGRect(origin: CGPoint.zero, size: bgSize), cornerRadius: radius)
        bezierPath.addClip()
        UIGraphicsGetCurrentContext()!.addPath(bezierPath.cgPath)
        // 2.绘制背景图片
        bgImage.draw(in: CGRect(origin: CGPoint.zero, size: bgSize))
        if iconImage != nil {
            // 3.绘制头像
            let width: CGFloat = iconSize.width
            let height: CGFloat = iconSize.height
            let x = (bgSize.width - width) * 0.5
            let y = (bgSize.height - height) * 0.5
            iconImage!.draw(in: CGRect(x: x, y: y, width: width, height: height))
        }
        // 4.取出绘制号的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // 5.关闭上下文
        UIGraphicsEndImageContext()
        // 6.返回合成好的图片
        return newImage!
    }
    
    // 将图片缩放成指定尺寸（多余部分自动删除）
    func scaled(to newSize: CGSize) -> UIImage {
        //计算比例
        let aspectWidth  = newSize.width/size.width
        let aspectHeight = newSize.height/size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
        
        //图片绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = 0
        scaledImageRect.origin.y    = 0
        
        //绘制并获取最终图片
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)//图片不失真
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}


