//
//  WQMapExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/24.
//  Copyright © 2020 wq. All rights reserved.
//

import Foundation

extension Dictionary {
    
    /**< 判断是否可用 */
    var available: Bool {
        get {
            let tempDictionary = self as? [String: Any]
            return tempDictionary != nil && tempDictionary?.keys.count ?? 0 > 0
        }
    }
    
    /**< 字典转字符串 */
    var jsonRepresentation: String {
        get {
            do {
                let data = try JSONSerialization.data(withJSONObject: self, options: [])
                return String(data: data, encoding: String.Encoding.utf8) ?? ""
            } catch { }
            return ""
        }
    }
    
    /**< 获取 */
    func objectForKey(_ key: String) -> Any {
        let tempDictionary = self as? [String: Any]
        let value = tempDictionary![key] as AnyObject
        if value is String {
            return value
        }
        return Void.self
    }

    /**< 设值 */
    mutating func setValue(_ value: Any, forKey key: String) {
        var tempDictionary = self as? [String: Any]
        tempDictionary![key] = value
        self = tempDictionary as! Dictionary<Key, Value>
    }
    
}

extension Dictionary {

    func parametersLog() -> String {
        if (self.count == 0) { return "[ : ]" }
        var string: String = ""
        for (key, value) in self {
            let keyString: String = (key is String) ? key as! String: ""
            let valueString: Any? = value
            string = string.appendingFormat("\t%@", keyString)
            string.append(" : ")
            if valueString != nil {
                let sssss = "\(valueString!)\n"
                string.append(sssss)
            }
        }
        string.append("]\n")
        return string
    }
    
}
