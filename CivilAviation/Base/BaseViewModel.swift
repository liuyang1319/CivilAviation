//
//  BaseViewModel.swift
//  LipstickMachine
//
//  Created by easyto on 2019/2/28.
//  Copyright © 2019年 easyto. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {
    
//    #if DEBUG // 开发环境
    
    @objc static let URL_HOST   = "https://mp.caac.gov.cn/cmsPortal/license/r3"
//    @objc static let URL_HOST   = "http://116.62.190.52:22561"
//    @objc static let IM_APP_KEY = "ae73ae44735f44f4a3062784ad12687c"
//    #elseif TESTING // 测试环境
//    @objc static let URL_HOST   = "http://tapi.effyic.com"
//    @objc static let IM_APP_KEY = "8e3f603a2af66e789676ab00c7da7a04"
//    #elseif RELEASE // 生产环境
//    @objc static let URL_HOST   = "https://api.effyic.com"
//    @objc static let IM_APP_KEY = "a2dc89eac7de46e7a4d9ad353d31aaf8"
//    #endif
    static let URL_APP          = URL_HOST + "/app"
    static let ERROR_DESC       = "服务器繁忙，请重试。"
    static let REQUEST          = AFHttpRequest.share
    
}
