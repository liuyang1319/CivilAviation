//
//  Array+Extrnsion.swift
//  Consult
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 com.easyto.consult. All rights reserved.
//

import UIKit


extension Array {

    mutating func removeObject(obj: Element) {
        if obj == nil {
            return
        }
        
        let array: NSMutableArray = NSMutableArray.init(array: self)
        if array.contains(obj) {
            array.remove(obj)
        }
        
        if self.count > array.count {
            self.removeAll()
            
            for item in array {
                let element: Element = item as! Element
                self.append(element)
            }
        }
        
    }
    
    mutating func insertFromArray(array: [Element], at: Int) {
        for item: Element in array {
            self.insert(item, at: at)
        }
    }
    
    /// 数组内中文按拼音字母排序
    ///
    /// - Parameter ascending: 是否升序（默认升序）
    func sortedByPinyin(ascending: Bool = true) -> Array<String>? {
        if self is Array<String> {
            return (self as! Array<String>).sorted { (value1, value2) -> Bool in
                let pinyin1 = value1.transformToPinyin()
                let pinyin2 = value2.transformToPinyin()
                return pinyin1.compare(pinyin2) == (ascending ? .orderedAscending : .orderedDescending)
            }
        }
        return nil
    }
    
    // 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
