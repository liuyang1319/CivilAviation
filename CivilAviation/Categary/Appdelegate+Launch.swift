//
//  Appdelegate+Launch.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import Foundation
extension AppDelegate {
    /// 加载初始界面
    func loadLaunch() {
        window = UIWindow.init(frame: kScreenBounds)
        window?.makeKeyAndVisible()
        
        if LoginTool.isAutoLogin() {
            loginSuccess()
        } else {
            logoutSuccess()
        }
        
        addNotification()
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loginSuccess),
                                               name: NSNotification.Name.init(kLoginEvent),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(logoutSuccess),
                                               name: NSNotification.Name.init(kLogoutEvent),
                                               object: nil)
    }
    
    private func getTabbarController() -> LYTabbarController {
        let tab = LYTabbarController()
        return tab
    }
    
    private func getLoginController() -> LYLoginController {
        let loginController = LYLoginController.init(nibName: "LYLoginController", bundle: nil)
        return loginController
    }
    
    @objc private func loginSuccess() {
        window?.rootViewController = getTabbarController()
    }
    
    @objc private func logoutSuccess() {
        LoginTool.setToken(token: "")
        LoginTool.setAutoLogin(autoLogin: false)
        window?.rootViewController = getLoginController()
    }
}
