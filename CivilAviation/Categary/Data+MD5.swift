//
//  Data+MD5.swift
//  SchoolChat_Parent_iOS
//
//  Created by easyto on 2019/11/19.
//  Copyright © 2019 liuyang. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
    
    func getMd5() -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = withUnsafeBytes { (bytes) in
            CC_MD5(bytes, CC_LONG(count), &digest)
        }
        var digestHex = ""
        for index in 0 ..< Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }
    
}
