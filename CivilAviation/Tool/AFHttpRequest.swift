//
//  AFHttpRequest.swift
//  PartTime
//
//  Created by easyto on 2019/6/24.
//  Copyright © 2019年 liuyang. All rights reserved.
//

import UIKit
import Foundation

class AFHttpRequest: NSObject {
    
    @objc static let share = AFHttpRequest()
    
    var enableMessage: Bool = false
    var defaultParams: [String : Any] = [:]
    var currentTask: [URLSessionTask] = []
    var networkErrorView: NetworkRequestErrorView = NetworkRequestErrorView.instanceView(type: "NetworkRequestErrorView") as! NetworkRequestErrorView
    
    static fileprivate let networkManager = AFNetworkReachabilityManager.shared()
    fileprivate let sessionManager = AFHTTPSessionManager.init(baseURL: URL.init(string: "https://api.effyic.com"))
    fileprivate let securityPolicy: AFSecurityPolicy? = nil
    
    //判断网络是否连接上
    static func isNetworkConnected() -> Bool {
        return networkManager.networkReachabilityStatus != .notReachable
    }
    
    static func isWifiConnected() -> Bool {
        return networkManager.networkReachabilityStatus == .reachableViaWiFi
    }
    
    static func checkNetworkEnabled(callBack :@escaping ((Bool)->())) {
        let networkManager = AFNetworkReachabilityManager.shared()
        networkManager.setReachabilityStatusChange { (state: AFNetworkReachabilityStatus) in
            switch state {
            case .unknown:
                callBack(false)
            case .notReachable:
                callBack(false)
            case .reachableViaWWAN, .reachableViaWiFi:
                callBack(true)
            default: break
            }
        }
        networkManager.startMonitoring()
    }
    
    //post请求
    @objc func requestPOST(url: String, callback: @escaping(_ data: Any?, _ error: Error?, _ errorDescription: String?) -> ()) {
        requestPOST(url: url, params: defaultParams, isShowHud: false, callback: callback)
    }
    
    @objc func requestPOST(url: String, params: [String: Any], callback: @escaping(_ data: Any?, _ error: Error?, _ errorDescription: String?) -> ()) {
        requestPOST(url: url, params: params, isShowHud: false, callback: callback)
    }
    
    @objc func requestPOST(url: String, params: [String: Any], isShowHud: Bool, callback: @escaping(_ data: Any?, _ error: Error?, _ errorDescription: String?) -> ()) {
        
        if isShowHud {
            SVProgressHUD.show()
        }
        
        let dict = setting(params: params)
        print("url:------ " + url)
//        print("param:------ \(dict)")
        sessionManager.post(url, parameters: dict, progress: { (progress: Progress) in
            
        }, success: { (task: URLSessionDataTask, responseObject: Any) in
            
            self.analysis(task: task, url: url, responseObject: responseObject, callback: callback)
        }) { (task: URLSessionDataTask?, error: Error) in
            self.analysisError(task: task!, error: error, callback: callback)
        }
    }
    
    //get请求
    @objc func requestGET(url: String, callback: @escaping(_ responseObject: Any?, _ error: Error?, _ errorDescription: String?) -> ()) {
        requestGET(url: url, params: defaultParams, isShowHud: false, callback: callback)
    }
    
    @objc func requestGET(url: String, params: [String: Any], callback: @escaping(_ responseObject: Any?, _ error: Error?, _ errorDescription: String?) -> ()) {
        requestGET(url: url, params: params, isShowHud: false, callback: callback)
    }
    
    @objc func requestGET(url: String, params: [String: Any], isShowHud: Bool, callback: @escaping(_ responseObject: Any?, _ error: Error?, _ errorDescription: String?) -> ()) {
        if isShowHud {
            SVProgressHUD.show()
        }
        
        let dict = setting(params: params)
        print("url:------ " + url)
        print("param:------ \(dict)")
        
        sessionManager.get(url, parameters: dict, progress: { (progress: Progress) in
            
        }, success: { (task: URLSessionDataTask, responseObject: Any) in
            
            self.analysis(task: task, url: url, responseObject: responseObject, callback: callback)
        }) { (task: URLSessionDataTask?, error: Error) in
            self.analysisError(task: task!, error: error, callback: callback)
        }
    }
    
    @objc func download(url: String, path: String, isShowHub: Bool, callback: @escaping(_ progress: Progress?, _ iscomplet: Bool, _ url: String?, _ error: Error?) -> ()) {
        
        if url.count == 0 || path.count == 0 {
            print("url count is 0.")
            return
        }
        
        if isShowHub {
            SVProgressHUD.show()
        }
        
        let urlR = URL.init(string: url)
        let request = URLRequest.init(url: urlR!)
        let filePath = path + urlR!.lastPathComponent
        
        sessionManager.downloadTask(with: request, progress: { (progress) in
            callback(progress, false, nil, nil)
        }, destination: { (targetPath, response) -> URL in
            return URL.init(fileURLWithPath: filePath)
        }) { (response, filePath, error) in
            SVProgressHUD.dismiss()
            callback(nil, true, url, error)
        }
    }
    
    private func analysis(task: URLSessionDataTask, url: String, responseObject: Any, callback: @escaping(_ responseObject: Any?, _ error: Error?, _ errorDescription: String?) -> ()) {
        SVProgressHUD.dismiss()
        
        if responseObject is [String : Any] {
            let object: [String : Any] = responseObject as! [String : Any];
            let data = object["data"]
            let code = object["code"] as! Int
            if code == RESPONSE_CODE_OK {
                callback(data, nil, nil)
            } else if code == RESPONSE_CODE_NO_TOKEN || code == RESPONSE_CODE_TOKEN_FAIL {
                LoginTool.setToken(token: "")
                NotificationCenter.default.post(Notification.init(name: Notification.Name.init(kLogoutEvent)))
                callback(
                    nil,
                    NSError.init(
                        domain: object["msg"] as! String,
                        code: object["code"] as! Int,
                        userInfo: nil
                    ),
                    object["msg"] as? String
                )
            } else {
                callback(
                    nil,
                    NSError.init(
                        domain: object["msg"] as! String,
                        code: object["code"] as! Int,
                        userInfo: nil
                    ),
                    object["msg"] as? String
                )
            }
        } else {
            callback(responseObject, nil, nil)
        }

        currentTask.removeAll()
        networkErrorView.disappear()
    }
    
    private func analysisError(task: URLSessionDataTask, error: Error, callback: @escaping(_ responseObject: Any?, _ error: Error?, _ errorDescription: String?) -> ()) {
        SVProgressHUD.dismiss()
//        CBToast.showToastAction(message: "当前网络不可用，请检查您的网络设置。")
        callback(nil, error, error.localizedDescription)
//        analysisHeaderFields(task: task)
//        currentTask.append(task)
//        showNetworkRequestErrorView()
    }
    
    private func analysisHeaderFields(task: URLSessionDataTask) {
        let response = task.response
        if response == nil || !(response is HTTPURLResponse) {
            return
        }
        
        let headers = (response as! HTTPURLResponse).allHeaderFields
        if !headers.contains(where: {($0.key is String) && ($0.key as! String) == REFRESH_CONTACT}) {
            return
        }
        
        let isRefreshContact = headers[REFRESH_CONTACT] as! NSString
        if isRefreshContact != "true" {
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            NotificationCenter.default.post(name: Notification.Name(kRefreshContact), object: nil)
        }
    }
    
    private func setting(params: [String : Any]) -> [String : Any] {
        var dict: [String : Any] = NSMutableDictionary.init(dictionary: params) as! [String : Any]
//        dict["deviceId"] = getDeviceId()
        if dict.keys.contains(JSON) {
            dict.removeValue(forKey: JSON)
            sessionManager.requestSerializer = AFJSONRequestSerializer()
        } else {
            sessionManager.requestSerializer = AFHTTPRequestSerializer()
        }
        
        sessionManager.securityPolicy.allowInvalidCertificates = true
        let securityPolicy = customSecurityPolicy()
        if securityPolicy != nil {
            sessionManager.securityPolicy = securityPolicy!
        }
        
        //        if LoginTool.getUser()?.token.count != 0 {
        //            sessionManager.requestSerializer.setValue(LoginTool.getUser()?.token ?? "", forHTTPHeaderField: "token")
        //        }
        
        sessionManager.requestSerializer.setValue("ios", forHTTPHeaderField: "device")
        sessionManager.requestSerializer.setValue(LoginTool.getToken(), forHTTPHeaderField: "token")
        
        return dict
    }
    
    private func customSecurityPolicy() -> AFSecurityPolicy? {
        let cerPath = Bundle.main.path(forResource: "api.effyic.com", ofType: "cer")
        let cerData = NSData.init(contentsOfFile: cerPath ?? "")
        if cerData == nil {
            return nil
        }
        
        let setData = NSSet.init(object: cerData!)
        let secruityPolicy = AFSecurityPolicy.init(pinningMode: .certificate)
        secruityPolicy.pinnedCertificates = (setData as! Set<Data>)
        secruityPolicy.allowInvalidCertificates = false
        secruityPolicy.validatesDomainName = false
        return secruityPolicy
    }
    
    private func getDeviceId() -> String {
        let kDeviceIdPath = "deviceIdPath"
        var deviceId = UserDefaults.standard.object(forKey: kDeviceIdPath) as? String
        if deviceId == nil {
            deviceId = UUID.init().uuidString
            UserDefaults.standard.set(deviceId, forKey: kDeviceIdPath)
        }
        
        return deviceId!
    }
    
    private func getDeviceInfo() -> String {
        var info = "i,"
        info += "\(DeviceTool.getDevicename()),"
        info += "\(DeviceTool.getSystemVersion()),"
        info += "t,"
        info += "\(DeviceTool.getAppVersion()),"
        info += "\(DeviceTool.getUDID()),"
        info += "\(DeviceTool.getUUID()),"
        info += "\(DeviceTool.getSystemName())"
        
        print("deviceInfo: ---- \(info)")
        return info
    }
    
    func showNetworkRequestErrorView() {
        networkErrorView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        networkErrorView.retryButton.addTarget(self, action: #selector(retryButtonClicked), for: .touchUpInside)
        networkErrorView.dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        networkErrorView.appear()
    }
    
    @objc func dismissButtonClicked() {
        self.currentTask.removeAll()
        self.networkErrorView.disappear()
    }
    
    @objc func retryButtonClicked() {
        if currentTask.count == 0 {
            return
        }
        for task in currentTask {
            retryFailRequest(task: task)
        }
    }
    
    @objc func retryFailRequest(task: URLSessionTask?) {
        if task == nil {
            return
        }
        
        let currentRequest = task?.currentRequest
        let method = currentRequest?.httpMethod
        if currentRequest == nil {
            return
        }
        
        if (method?.contains("GET"))! || (method?.contains("POST"))! {
            let newTask = sessionManager.dataTask(with: currentRequest!, uploadProgress: { (progress) in
            }, downloadProgress: { (progress) in
            }) { (response, responseObject, error) in
                if error != nil {
                    print((error! as NSError).domain as NSString)
                    return
                }
                
                self.currentTask.removeAll()
                self.networkErrorView.disappear()
            }
            newTask.resume()
        } else {
            let newTask = sessionManager.downloadTask(with: currentRequest!, progress: { (Progressprogress) in
            }, destination: { (targetPathURL, response) -> URL in
                return targetPathURL
            }) { (response, filePathURL, error) in
                if error != nil {
                    print((error! as NSError).domain as NSString)
                    return
                }
                
                self.currentTask.removeAll()
                self.networkErrorView.disappear()
            }
            newTask.resume()
        }
    }
}

