//
//  LYNotificationViewModel.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/11.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYNotificationViewModel: BaseViewModel {

    static func getMessages(status: NotificationType, pageNum: Int, callback: @escaping(_ datas: [LYNotificationModel]?, _ error: Error?) -> ()) {
        let url = URL_APP + "/messages"
        let param = [
            "status" : status == .unRead ? "U" : "Y",
            "pageNum" : "\(pageNum)",
            "pageSize" : "10"
        ]
        
        REQUEST.requestGET(url: url, params: param) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            var datas: [LYNotificationModel] = []
            
            if result == nil || !(result is [String : Any]) {
                callback(datas, nil)
                return
            }
            
            let list = (result as! [String: Any])["list"]
            if list == nil || !(list is [[String : Any]]) {
                callback(datas, nil)
                return
            }
            
            for dic in list as! [[String : Any]] {
                let model = LYNotificationModel.deserialize(from: dic)
                datas.append(model!)
            }
            
            callback(datas, nil)
        }
    }
}
