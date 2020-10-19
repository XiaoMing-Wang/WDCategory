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
    
    func hexString() -> String {
        var t = ""
        let ts = [UInt8](self)
        for one in ts {
            t.append(String(format: "%02x", one))
        }
        return t
    }

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

    /** data转字典 */
    func dataToDictionary() -> [String: Any] {
        let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String: Any]
        return json ?? [:]
    }

    
    //崩溃
    /// md5+base64
    //    func base64Md5() -> String {
    //        let md5Data = self.MD5()
    //        let bytes = md5Data.bytes
    //    /** let data = NSData(bytes: bytes, length: Int(CC_MD5_DIGEST_LENGTH)) */
    //    /** return data.base64EncodedString(options: .lineLength64Characters) */
    //        return ""
    //    }
    
    //    func MD5() -> Data {
    //        let da = Data(count: Int(CC_MD5_DIGEST_LENGTH))
    //        let unsafe = [UInt8](self)
    //        return da.withUnsafeBytes { (bytes) -> Data in
    //            let b = bytes.baseAddress!.bindMemory(to: UInt8.self, capacity: 4).predecessor()
    //            let mb = UnsafeMutablePointer(mutating: b)
    //            CC_MD5(unsafe, CC_LONG(count), mb)
    //            return da
    //        }
    //    }
}
