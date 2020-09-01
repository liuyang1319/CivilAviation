//
//  LYPersonViewModel.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/11.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYPersonViewModel: BaseViewModel {
    
    // 个人信息
    static func getUserInfo(callback: @escaping(_ model:LYPersonModel?, _ error: Error?) -> ()) {
        let url = URL_APP + "/userInfo"
        REQUEST.requestGET(url: url) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            if result == nil {
                callback(nil, nil)
                return
            }
            
            let model = LYPersonModel.deserialize(from: (result as! [String : Any]))
            callback(model!, nil)
        }
    }
    
    // 成绩
    static func getExams(callback: @escaping(_ datas: [LYExamModel]?, _ error: Error?) -> ()) {
        let url = URL_APP + "/exams"
        REQUEST.requestGET(url: url) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error!)
                return
            }
            
            var datas: [LYExamModel] = []
            if result == nil || !(result is [String : Any]) {
                callback(datas, nil)
                return
            }
            
            let list = (result as! [String : Any])["list"]
            if list == nil || !(list is [[String : Any]]) {
                callback(datas, nil)
                return
            }
            
            for dic in list as! [[String : Any]] {
                let model = LYExamModel.deserialize(from: dic)
                datas.append(model!)
            }
            
            callback(datas, nil)
        }
    }
    
    //  失信行为
    static func getDishonestys(callback: @escaping(_ model: LYDishonestysModel?, _ error: Error?) -> ()) {
        let url = URL_APP + "/dishonesty"
        REQUEST.requestGET(url: url) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error!)
                return
            }
            
            if result == nil || !(result is [String : Any]) {
                callback(nil, nil)
                return
            }
            
            let model = LYDishonestysModel.deserialize(from: (result as! [String : Any]))
            callback(model, nil)
        }
    }
    
    // 上传图片
    static func upload(image: UIImage, callback: @escaping(_ url: String?, _ error: Error?) -> ()) {
        let url = URL_APP + "/upload"
        var data = image.pngData()
        if data == nil {
            data = image.jpegData(compressionQuality: 1.0)
        }
        let param = [
            "type" : "1",
            "file" : data ?? Data()
        ] as [String : Any]
        
        REQUEST.requestPOST(url: url, params: param, isShowHud: true) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            callback(result as? String, nil)
        }
    }
    
    // 个人信息提交
    static func userInfoUpload(fontUrl: String, reverseUrl: String, holdUrl: String, callback: @escaping(_ error: Error?) -> ()) {
        let url = URL_APP + "/userInfoUpdate"
        let param = [
            "fontUrl" : fontUrl,
            "reverseUrl" : reverseUrl,
            "holdUrl" : holdUrl
        ]
        
        REQUEST.requestPOST(url: url, params: param) { (result, error, errorDic) in
            callback(error)
        }
    }
    
    // APP版本更新接口
    static func getLatest(complate: @escaping(_ appVersion: String) -> ()) {
        let url = URL_APP + "/ios/latestVersion"
        let param = [
            "version" : DeviceTool.getAppVersion()
        ]
        
        REQUEST.requestGET(url: url, params: param) { (result, error, errorDic) in
            if error != nil {
                complate("")
                return
            }
            
            complate((result as! [String : Any])["appVersion"] as! String)
        }
    }
}
