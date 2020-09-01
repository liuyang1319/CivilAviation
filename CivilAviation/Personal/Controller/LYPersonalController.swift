//
//  LYPersonalController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/30.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYPersonalController: BaseController {

    private let kLYPersonalInfoCell = "LYPersonalInfoCell"
    private let kLYPersonalItemCell = "LYPersonalItemCell"
    private let iconArray = [
        "",
        "icon_mine_modify",
        "icon_mine_result",
        "icon_mine_proken",
        "icon_mine_about",
        "icon_mine_logout"
    ]
    private let titleArray = [
        "",
        "修改个人证件信息/Modify Information",
        "我的成绩/Examination Result",
        "失信行为记录/Record of Dishonesty",
        "关于/About",
        "注销登录/Logout"
    ]
    
    private var model: LYPersonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "个人信息", English: "Personal information")
        cellArray = [
            kLYPersonalInfoCell,
            kLYPersonalItemCell
        ]
        
        addTableViewHeader()
        getData()
    }

    override func addLeftBtn() {}
    
    override func getData() {
        LYPersonViewModel.getUserInfo { (model, error) in
            if error != nil {
                self.toastError(error: error!)
                return
            }
            
            if model == nil {
                self.toast(toast: "请刷新信息")
                return
            }
            
            self.model = model
            self.tableView.reloadData()
        }
    }
    
    private func logout() {
        let confirm = UIAlertAction.init(
            title: "确定",
            style: .default) { (action) in
                self.toast(toast: "已退出")
                NotificationCenter.default.post(Notification.init(name: Notification.Name.init(kLogoutEvent)))
        }
        alert(title: "确定退出登录么？", actions: [confirm])
    }
}

extension LYPersonalController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYPersonalInfoCell) as! LYPersonalInfoCell
            cell.setValue(model: model)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: kLYPersonalItemCell) as! LYPersonalItemCell
            cell.setValue(icon: iconArray[indexPath.row], title: titleArray[indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        default:
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let controller = LYPersonalModifyController()
            controller.model = model
            pushController(controller: controller)
        case 2:
            let controller = LYPersonalGradeController()
            pushController(controller: controller)
        case 3:
            let controller = LYPersonalDishnoestyController()
            controller.personInfo = model
            pushController(controller: controller)
        case 4:
            let controller = LYAboutController.init(nibName: "LYAboutController", bundle: nil)
            pushController(controller: controller)
        case 5:
            logout()
        default:
            break
        }
    }
}
