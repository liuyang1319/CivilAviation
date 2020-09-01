//
//  LYLicenseViewModel.swift
//  CivilAviation
//
//  Created by easyto on 2020/3/9.
//  Copyright © 2020 LiuYang. All rights reserved.
//

import UIKit

class LYLicenseViewModel: BaseViewModel {

    // 执照信息
    static func getLicense(callback: @escaping(_ model: LYLicenseModel?, _ error: Error?) -> ()) {
        let url = URL_APP + "/license"
        REQUEST.requestGET(url: url, params: [:], isShowHud: true) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            let model = LYLicenseModel.deserialize(from: (result as! [String : Any]))
            callback(model, nil)
        }
    }
    
    // 机型信息
    static func getPlaneType(pageNum: Int, callback: @escaping(_ datas: [LYPlaneTypeModel]?, _ error: Error?) -> ()) {
        let url = URL_APP + "/planeType"
        let param = [
            "pageNum" : "\(pageNum)",
            "pageSize" : "10"
        ]
        
        REQUEST.requestGET(url: url, params: param, isShowHud: true) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            var datas: [LYPlaneTypeModel] = []
            
            let data = result as! [String : Any]
            let list = data["list"] as! [[String : Any]]
            for dic in list {
                let model = LYPlaneTypeModel.deserialize(from: dic)
                datas.append(model!)
            }
            
            callback(datas, nil)
        }
    }
    
    // 获取二维码
    static func getQR(callback: @escaping(_ QR: String?, _ error: Error?) -> ()) {
        let url = URL_APP + "/qrCode"
        REQUEST.requestGET(url: url) { (result, error, errorDic) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            if result == nil {
                callback(nil, error)
                return
            }
            
            callback(((result as! [String : String])["url"]) ?? "", nil)
        }
    }
}
