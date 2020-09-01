//
//  Constant.swift
//  LipstickMachine
//
//  Created by easyto on 2019/2/28.
//  Copyright © 2019年 easyto. All rights reserved.
//

import Foundation

let kScreenBounds = UIScreen.main.bounds
let kScreenWidth = kScreenBounds.size.width
let kScreenHeight = kScreenBounds.size.height

let IsIphone5:Bool                               = (kScreenWidth == 320
    && kScreenHeight == 568) ? true : false
let IsIphoneX:Bool                               = ((kScreenWidth == 375
    && kScreenHeight == 812) || (kScreenWidth == 414
        && kScreenHeight == 896)) ? true : false
//常用高度
let StatusBarHeight: CGFloat                     = (IsIphoneX ? 44 : 20)
let NavigationHeight: CGFloat                    = 44.0
let TabBarHeight: CGFloat                        = (IsIphoneX ? (49 + 34) : 49)
let StatusBarAndNavHeight                       = (StatusBarHeight + NavigationHeight)
let TabbarSafeBottomMargin: CGFloat              = (IsIphoneX ? 34 : 0)

func getScal(height: CGFloat) -> CGFloat {
    return (kScreenWidth / 375) * height
}

//常用颜色
let TabbarTitleNormalColor                      = UIColor.black
let TabbarTitleSelectColor                      = NavigationBackgroundColor
let TabbarBackgroundColor                       = UIColor.init(hex: 0xEAE7EB)
let BackColor                                   = UIColor.init(hex: 0xF7F7F7)
let NavigationBackgroundColor                   = UIColor.init(hex: 0x427FC9)
let TextColor                                   = UIColor.init(hex: 0x5A5A5A)

let RESPONSE_CODE_OK          = 200
let RESPONSE_CODE_NO_TOKEN    = 4001
let RESPONSE_CODE_TOKEN_FAIL    = 4002
