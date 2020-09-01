//
//  LYExperienceViewModel.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/9.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYExperienceViewModel: BaseViewModel {

    static func getMaintenance(type: Int, pageNum: Int, callback: @escaping(_ datas: [LYMaintenanceModel]?, _ error: Error?) -> ()) {
        let url = URL_APP + "/maintainExperience"
        let param = [
            "type" : "\(type)",
            "pageNum" : "\(pageNum)",
            "pageSize" : "10"
        ]
        
        REQUEST.requestGET(url: url, params: param) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            var datas: [LYMaintenanceModel] = []
            let data = result as? [String : Any]
            if data == nil {
                callback(datas, nil)
                return
            }
            let list = data!["list"] as? [[String : Any]]
            if list == nil {
                callback(datas, nil)
                return
            }
            
            for dic in list! {
                let model = LYMaintenanceModel.deserialize(from: dic)
                datas.append(model!)
            }
            
            callback(datas, nil)
        }
        
    }
    
    // 培训经历
    static func getTrain(type: Int, pageNum: Int, callback: @escaping(_ datas: [LYTrainModel]?, _ error: Error?) -> ()) {
        let url = URL_APP + "/trainExperience"
        let param = [
            "type" : "\(type)",
            "pageNum" : "\(pageNum)",
            "pageSize" : "10"
        ]
        
        REQUEST.requestGET(url: url, params: param, isShowHud: true) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            var datas: [LYTrainModel] = []
            let data = result as? [String : Any]
            if data == nil {
                callback(datas, nil)
                return
            }
            let list = data!["list"] as? [[String : Any]]
            if list == nil {
                callback(datas, nil)
                return
            }
            
            for dic in list! {
                let model = LYTrainModel.deserialize(from: dic)
                datas.append(model!)
            }
            
            callback(datas, nil)
        }
    }
    
}
