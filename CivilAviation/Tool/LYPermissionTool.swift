//
//  LYPermissionTool.swift
//  CivilAviation
//
//  Created by easyto on 2019/12/31.
//  Copyright © 2019 LiuYang. All rights reserved.
//

import UIKit
import Photos

class LYPermissionTool: NSObject {

    /// 相机权限
    static func cameraPermission(callback: @escaping(_ result: Bool) -> ()) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    DispatchQueue.main.async {
                        callback(true)
                    }
                } else {
                    callback(false)
                }
            }
        case .authorized:
            callback(true)
        default:
            callback(false)
        }
    }
}
