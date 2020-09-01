//
//  String+getFirstLetter.swift
//  SchoolChat_Parent_iOS
//
//  Created by easyto on 2019/11/15.
//  Copyright © 2019 liuyang. All rights reserved.
//

import UIKit

extension String {
    // MARK: - 判断字符串中是否有中文
    func isIncludeChinese() -> Bool {
        for ch in self.unicodeScalars {
            if (0x4e00 < ch.value  && ch.value < 0x9fff) { return true } // 中文字符范围：0x4e00 ~ 0x9fff
        }
        return false
    }
    
    // MARK: - 将中文字符串转换为ASCII
    // Parameter hasBlank: 是否带空格（默认不带空格）
    func transformToASCII() -> UInt32 {
        
        // 获取拼音字符串
        let pinyinString = transformToPinyin(hasBlank: false)
    
        var terminator: UInt32 = 0
        for chart in pinyinString.unicodeScalars {
            terminator += chart.value
        }
        return terminator
    }
    
    // MARK: - 将中文字符串转换为拼音
    // Parameter hasBlank: 是否带空格（默认不带空格）
    func transformToPinyin(hasBlank: Bool = false) -> String {
        
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: self)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调(用此方法大大提高遍历的速度)
        var pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        // 去掉空格
        pinyinString = hasBlank ? pinyinString : pinyinString.replacingOccurrences(of: " ", with: "")
        // 将拼音首字母装换成大写
        let strPinYin = polyphoneStringHandle(nameString: self, pinyinString: pinyinString).uppercased()
        return strPinYin
    }
    
    // MARK: - 获取首字母(传入汉字字符串, 返回大写拼音首字母)
    func getFirstLetter() -> (String) {
        
        // 获取拼音字符串
        let pinyinString = transformToPinyin(hasBlank: false)
        // 截取大写首字母
        let firstString = pinyinString.substring(to: pinyinString.index(pinyinString.startIndex, offsetBy:1))
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
    
    /// 多音字处理
    private func polyphoneStringHandle(nameString:String, pinyinString:String) -> String {
        if nameString.hasPrefix("长") {return "chang"}
        if nameString.hasPrefix("沈") {return "shen"}
        if nameString.hasPrefix("厦") {return "xia"}
        if nameString.hasPrefix("地") {return "di"}
        if nameString.hasPrefix("重") {return "chong"}
        
        return pinyinString;
    }
}
