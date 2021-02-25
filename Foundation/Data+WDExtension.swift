//
//  Data+WXMExtension.swift
//  im-client
//
//  Created by wq on 2020/6/13.
//  Copyright © 2020 IM. All rights reserved.
//

// use:
// let t = "Hello world!!"
// var d = t.data(using: .utf8)!
// print(d.MD5().hexString())
// 1d94dd7dfd050410185a535b9575e184
import Foundation
import UIKit
import CommonCrypto

extension Data {
    
    /**< data转string */
    func hexString() -> String {
        var t = ""
        let ts = [UInt8](self)
        for one in ts {
            t.append(String(format: "%02x", one))
        }
        return t
    }

    /**< data转MD5 */
    func md5String() -> String {
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
    
    /**< data转字典  */
    func dataToDictionary() -> [String: Any] {
        let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String: Any]
        return json ?? [:]
    }

}
