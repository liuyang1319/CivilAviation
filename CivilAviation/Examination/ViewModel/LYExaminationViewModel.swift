//
//  LYExaminationPlansViewModel.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/10.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYExaminationViewModel: BaseViewModel {
    
    // 考试计划
    static func getPlains(type: Int, planName: String, pageNum: Int, callback: @escaping(_ datas: [LYExaminationPlanModel]?, _ error: Error?) -> ()) {
        let url = URL_APP + "/plans"
        let param = [
            "planType" : "\(type)",
            "planName" : planName,
            "pageNum" : "\(pageNum)",
            "pageSize" : "10"
        ]
        
        REQUEST.requestGET(url: url, params: param) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            var datas: [LYExaminationPlanModel] = []
            if result == nil {
                callback(datas, nil)
                return
            }
            
            let list = (result as! [String : Any])["list"]
            if list == nil || !(list is [[String : Any]]) {
                callback(datas, nil)
                return
            }
            
            for dic in list as! [[String : Any]] {
                let model = LYExaminationPlanModel.deserialize(from: dic)
                datas.append(model!)
            }
            
            callback(datas, nil)
        }
    }
    
    // 报名信息
    static func getPlansApplied(planName: String, pageNum: Int, callback: @escaping(_ datas: [LYExaminationPlanModel]?, _ error: Error?) -> ()) {
        
        let url = URL_APP + "/plansApplied"
        let param = [
            "planName" : planName,
            "pageNum" : "\(pageNum)",
            "pageSize" : "10"
        ]
        
        REQUEST.requestGET(url: url, params: param) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            var datas: [LYExaminationPlanModel] = []
            if result == nil {
                callback(datas, nil)
                return
            }
            
            let list = (result as! [String : Any])["list"]
            if list == nil || !(list is [[String : Any]]) {
                callback(datas, nil)
                return
            }
            
            for dic in list as! [[String : Any]] {
                let model = LYExaminationPlanModel.deserialize(from: dic)
                datas.append(model!)
            }
            
            callback(datas, nil)
        }
    }
    
    // 报名选择模块与类别接口
    static func getItems(type: Int, callback: @escaping(_ result: [String : Any]?, _ error: Error?) -> ()) {
        let url = URL_APP + "/items"
        let param = [
            "type" : "\(type)"
        ]
        
        REQUEST.requestGET(url: url, params: param) { (result, error, errorDic) in
            callback(result as? [String : Any], error)
        }
    }
    
    // 考试计划报名
    static func apply(major: String, planId: String, items: [String], callback: @escaping(_ error: Error?) -> ()) {
        let url = URL_APP + "/applyIos"
        let itemString = items.joined(separator: ",")
        let param = [
            "major" : major,
            "planId" : planId,
            "items" : itemString
        ] as [String : Any]
        
        REQUEST.requestPOST(url: url, params: param, isShowHud: true) { (result, error, errorDic) in
            callback(error)
        }
    }
}
