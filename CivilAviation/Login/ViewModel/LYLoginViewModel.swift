//
//  LYLoginViewModel.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/9.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYLoginViewModel: BaseViewModel {
    
    static func login(username: String,
                      password: String,
                      isRemember: Bool,
                      isAutoLogin: Bool,
                      callback: @escaping(_ error: Error?) -> ()) {
        let url = URL_APP + "/loginIos"
        let param = [
            "username" : username,
            "password" : password
        ]
        
        REQUEST.requestPOST(url: url, params: param, isShowHud: true) { (result, error, errorDic) in
            if error != nil {
                callback(error)
                return
            }
            
            let token = result as? String
            if token == nil {
                let httpError = HttpError.init((((result as! [String : Any])["msg"]) as? String) ?? "")
                callback(httpError)
                return
            }
            
            LoginTool.setToken(token: token ?? "")
            LoginTool.setAutoLogin(autoLogin: isAutoLogin)
            LoginTool.setAccount(account: isRemember ? username : "")
            LoginTool.setRemember(remember: isRemember)
            callback(nil)
        }
    }
}
