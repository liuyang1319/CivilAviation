//
//  LYLoginController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/26.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYLoginController: BaseController {

    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rememberBtn: UIButton!
    @IBOutlet weak var autoLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.removeFromSuperview()
        view.backgroundColor = NavigationBackgroundColor
        setupUI()
    }

    private func setupUI() {
        rememberBtn.isSelected = LoginTool.isRemember()
        autoLoginBtn.isSelected = LoginTool.isAutoLogin()
        if LoginTool.isRemember() {
            account.text = LoginTool.getAccount()
        }
    }

    @IBAction func remenberBtnClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func autoLoginBtnClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func loginBtnClicked() {
        if !isCanLogin() {
            return
        }
        
        LYLoginViewModel.login(
            username: account.text!,
            password: password.text!,
            isRemember: rememberBtn.isSelected,
            isAutoLogin: autoLoginBtn.isSelected) { (error) in
                if error != nil {
                    self.toastError(error: error!)
                    return
                }
                
                NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: kLoginEvent)))
        }
    }
    
    private func isCanLogin() -> Bool {
        if account.text?.length == 0 {
            toast(toast: "请输入正确的用户名")
            return false
        }
        
        if password.text?.length == 0 {
            toast(toast: "请输入正确的密码")
            return false
        }
        
        return true
    }
}
