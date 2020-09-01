//
//  Tool.swift
//  NIM
//
//  Created by easyto on 2019/8/6.
//  Copyright © 2019 Netease. All rights reserved.
//

import UIKit

class Tool: NSObject {

    @objc static func getNavigation() -> UINavigationController {
        let window: UIWindow? = UIApplication.shared.delegate!.window!
        let tabbar = window?.rootViewController as! UITabBarController
        let navigation = tabbar.selectedViewController as! UINavigationController
        return navigation
    }
    
    @objc static func getCurrentVC() -> UIViewController? {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        let currentVC = Tool.getCurrentVCFrom(rootVC: rootViewController!)
        return currentVC
    }
    
    @objc static func getCurrentVCFrom(rootVC: UIViewController?) -> UIViewController? {
        var currentVC: UIViewController?
        if (rootVC?.presentedViewController != nil) {
            currentVC = rootVC?.presentedViewController
        }
        
        if rootVC is UITabBarController {
            let selectedVC = (rootVC as! UITabBarController).selectedViewController
            currentVC = Tool.getCurrentVCFrom(rootVC: selectedVC)
        } else if rootVC is UINavigationController {
            let visibleVC = (rootVC as! UINavigationController).visibleViewController
            currentVC = Tool.getCurrentVCFrom(rootVC: visibleVC)
        } else {
            currentVC = rootVC
        }
        return currentVC
    }
    
    @objc static func getDictionaryFromJSONString(jsonString: String) -> [String : Any] {
        let jsonData = jsonString.data(using: .utf8)
        let dict = try? JSONSerialization.jsonObject(
            with: jsonData!,
            options: .mutableContainers
        )
        
        if dict != nil {
            return dict as! [String : Any]
        }
        return [:]
    }

    @objc static func getArrayFromJSONString(jsonString: String) -> [AnyObject] {
        let jsonData:Data = jsonString.data(using: .utf8)!
        let array = try? JSONSerialization.jsonObject(
            with:jsonData,
            options: .mutableContainers
        )
        if array != nil {
            return array as! [AnyObject]
        }
        return array as! [AnyObject]
        
    }
    
    @objc static func getJSONStringFromDictionary(dictionary: [String : Any]) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : Data! = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []
        ) as Data?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    @objc static func getJSONStringFromArray(array: [AnyObject]) -> String {
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("无法解析出JSONString")
            return ""
        }
        
        let data : Data! = try? JSONSerialization.data(
            withJSONObject: array,
            options: []
        ) as Data?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    @objc static func saveFileToLocalDisk(fileData: Data, fileType: String, fileName: String) -> Bool {
        let name = fileName + "." + fileType
        let fileManager = FileManager.default
        guard let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else { return false }
        let filePath = documentPath + "/Files/" + name
        
        let fileExists: Bool = fileManager.fileExists(atPath: filePath)
        if !fileExists {
            fileManager.createFile(atPath: filePath, contents:nil, attributes:nil)
            
            let handle = FileHandle(forWritingAtPath:filePath)
            handle?.write(fileData)
            let writeSuccess: Bool = fileManager.fileExists(atPath: filePath)
            return writeSuccess
        }
        return true
    }
    
    @objc static func getFileFromLocalDisk(filePath: String) -> Data? {
        let fileManager = FileManager.default
        guard let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else { return nil }
        let targetFilePath = documentPath + filePath
        let fileExists: Bool = fileManager.fileExists(atPath: targetFilePath)
        if !fileExists {
            return nil
        } else {
            let handle = FileHandle(forReadingAtPath: targetFilePath)
            return handle?.readDataToEndOfFile()
        }
    }
    
    @objc static func getPointerAddress(obj: AnyObject?) -> Int {
        var obj = obj
        /// 方案二：测试中 发现作用在<值类型>的对象上能确保正确性
        let hashValue = withUnsafePointer(to: &obj) { (point) -> Int in
            /// 闭包的实现有多种，可根据自己需求修改
            return point.hashValue
        }
//        let point = Unmanaged<AnyObject>.passUnretained(obj as AnyObject).toOpaque()
//        let hashValue = point.hashValue // 这个就是唯一的，可以作比较
        return hashValue
    }
    
}
