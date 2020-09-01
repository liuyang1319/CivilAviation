//
//  LYNotificationController.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/27.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit

class LYNotificationController: BaseController {

    private let kLYNotificationSelectView = "LYNotificationSelectView"
    private let kLYNotificationCell = "LYNotificationCell"
    
    private var type: NotificationType = .unRead
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(title: "通知", English: "Message")
    }
    
    override func addLeftBtn() {}
    
    override func initTableView() {
        super.initTableView()
        tableView.mj_h -= TabBarHeight
        cellArray = [
            kLYNotificationCell
        ]
        tableView.register(
            UINib.init(nibName: kLYNotificationSelectView, bundle: nil),
            forHeaderFooterViewReuseIdentifier: kLYNotificationSelectView
        )
        
        reFreshData()
    }
    
    override func getData() {
        LYNotificationViewModel.getMessages(status: type, pageNum: nextPageFlag) { (datas, error) in
            if error != nil {
                self.toastError(error: error!)
                return
            }
            
            self.processData(datas: datas!, complate: {
                self.dataArray += datas!
                self.tableView.reloadData()
            })
            
        }
    }
}

extension LYNotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLYNotificationCell) as! LYNotificationCell
        if dataArray.count > indexPath.row {
            cell.setValue(model: dataArray[indexPath.row] as! LYNotificationModel)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = LYNotificationDetailController()
        pushController(controller: controller)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: kLYNotificationSelectView) as! LYNotificationSelectView
        view.delegate = self
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

extension LYNotificationController: LYNotificationSelectViewDelegate {
    /// LYNotificationSelectViewDelegate
    func typeBtnClicked(type: NotificationType) {
        self.type = type
        reFreshData()
    }
    
    
}
