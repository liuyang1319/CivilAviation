//
//  LYTabbarController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYTabbarController: UITabBarController {

    private let kTitleString = "title"
    private let kNormalImg = "img"
    private let kSelectedImg = "selectedImg"
    private let kClass = "class"
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        UITabBar.appearance().tintColor = TabbarBackgroundColor
        initControllers()
    }
    
    private func initControllers() {
        viewControllers = nil
        let items = [
            [
                kTitleString : "执照",
                kNormalImg : "tab_license",
                kSelectedImg : "tab_license_select",
                kClass : LYLicenseController()
            ], [
                kTitleString : "经历",
                kNormalImg : "tab_experience",
                kSelectedImg : "tab_experience_select",
                kClass : LYExperienceController()
            ], [
                kTitleString : "考试",
                kNormalImg : "tab_examination",
                kSelectedImg : "tab_examination_select",
                kClass : LYExaminationController()
            ], [
                kTitleString : "通知",
                kNormalImg : "tab_notification",
                kSelectedImg : "tab_notification_select",
                kClass : LYNotificationController()
            ], [
                kTitleString : "个人",
                kNormalImg : "tab_mine",
                kSelectedImg : "tab_mine_selected",
                kClass : LYPersonalController()
            ],
        ]
        
        var childController: [LYNavigationController] = []
        
        for item in items {
            
            let controller = item[kClass] as! UIViewController
            let navigation = LYNavigationController.init(rootViewController: controller)
            navigation.tabBarItem.title = item[kTitleString] as? String
            navigation.tabBarItem.image = UIImage.init(named: item[kNormalImg]! as! String)
            navigation.tabBarItem.selectedImage = UIImage.init(named: item[kSelectedImg] as! String)
            navigation.tabBarItem.setTitleTextAttributes(
                [NSAttributedString.Key.foregroundColor : TabbarTitleNormalColor],
                for: .normal
            )
            navigation.tabBarItem.setTitleTextAttributes(
                [NSAttributedString.Key.foregroundColor : TabbarTitleSelectColor],
                for: .selected
            )
            
            childController.append(navigation)
        }
        
        viewControllers = childController
        selectedIndex = 0
    }

}
