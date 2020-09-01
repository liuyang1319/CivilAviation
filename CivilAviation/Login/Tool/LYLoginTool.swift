//
//  LoginTool.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LoginTool: NSObject {
    static private let kTokenKey = "kTokenKey"
    static private let kRememberKey = "kRememberKey"
    static private let kAutoLogin = "kAutoLogin"
    static private let kAccount = "kAccount"
    
    static private var token: String {
        set {
            UserDefaults.standard.set(newValue, forKey: kTokenKey)
        }
        
        get {
            return (UserDefaults.standard.object(forKey: kTokenKey) as? String) ?? ""
        }
    }
    
    static private var account: String {
        set {
            UserDefaults.standard.set(newValue, forKey: kAccount)
        }
        
        get {
            return (UserDefaults.standard.object(forKey: kAccount) as? String) ?? ""
        }
    }
    
    static private var remember: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: kRememberKey)
        }
        
        get {
            return UserDefaults.standard.bool(forKey: kRememberKey)
        }
    }
    
    static private var autoLogin: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: kAutoLogin)
        }
        
        get {
            return UserDefaults.standard.bool(forKey: kAutoLogin)
        }
    }

    // 设置是否自动登录
    static func setAutoLogin(autoLogin: Bool) {
        self.autoLogin = autoLogin
    }
    
    // 是否自动登录
    static func isAutoLogin() -> Bool {
        return autoLogin
    }
    
    // 是否保存用户名
    static func isRemember() -> Bool {
        return remember
    }
    
    static func setRemember(remember: Bool) {
        self.remember = remember
    }
    
    // 获取token
    static func getToken() -> String {
        return token
    }
    
    // 设置token
    static func setToken(token: String) {
        self.token = token
    }
    
    // 获取帐号
    static func getAccount() -> String {
        return account
    }
    
    // 保存帐号
    static func setAccount(account: String) {
        self.account = account
    }
}
