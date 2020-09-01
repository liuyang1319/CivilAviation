//
//  DeviceTool.swift
//  PartTime
//
//  Created by easyto on 2019/10/11.
//  Copyright © 2019 liuyang. All rights reserved.
//

import UIKit
import AdSupport

class DeviceTool: NSObject {

    /// 获取当前设备IP
    static func getOperatorsIP() -> String? {
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first
    }
    
    //获取本机无线局域网ip
    static func getWifiIP() -> String? {
        
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddr) == 0 else {
            return nil
        }
        guard let firstAddr = ifaddr else {
            return nil
        }
        
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            // Check for IPV4 or IPV6 interface
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Check interface name
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                    // Convert interface address to a human readable string
                    var addr = interface.ifa_addr.pointee
                    var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr,socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostName)
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return address
    }
    
    /// 获取设备版本号
    static func getDevicename() -> String {
        return UIDevice.current.model
    }

    /// 获取iPhone名称
    static func getPhoneName() -> String {
        return UIDevice.current.name
    }
    
    /// 获取app版本号
    static func getAppVersion() -> String {
        return (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String) ?? ""
    }
    
    /// 获取appName
    ///
    /// - Returns: app Name
    static func getAppname() -> String {
        return (Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String) ?? ""
    }
    
    /// 当前系统名称
    static func getSystemName() -> String {
        return UIDevice.current.systemName
    }
    
    /// 当前系统版本号
    static func getSystemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /// 获取udid(不变)
    ///
    /// - Returns: udid
    static func getUDID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    /// 获取uuid(变动)
    ///
    /// - Returns: uuid
    static func getUUID() -> String {
        return NSUUID.init().uuidString
    }
    
    static func getDeviceLanguage() -> String {
        let languages = Locale.preferredLanguages
        return languages.first ?? ""
    }
}
