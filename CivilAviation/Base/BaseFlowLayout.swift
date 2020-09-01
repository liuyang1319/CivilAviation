//
//  BaseFlowLayout.swift
//  LipstickMachine
//
//  Created by easyto on 2019/3/2.
//  Copyright © 2019年 easyto. All rights reserved.
//

import UIKit

class BaseFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        
        minimumLineSpacing = 0       //cell的间距
        minimumInteritemSpacing = 0
        sectionInset = .zero
        collectionView?.alwaysBounceVertical = true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //获取系统帮我们计算好的Attributes
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        if (layoutAttributes?.count ?? 0) == 0 {
            return layoutAttributes
        }
        
        for index in 1..<layoutAttributes!.count {
            //获取cell的Attribute，根据上一个cell获取最大的x，定义为originX
            let current = layoutAttributes![index]
            let last = layoutAttributes![index-1]
            let originX = last.frame.origin.x + last.frame.size.width
            
            if current.frame.origin.y == last.frame.origin.y {
                current.frame.origin.x = originX+minimumInteritemSpacing
            }
        }
        
        return layoutAttributes
    }
}
