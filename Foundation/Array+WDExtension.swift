//
//  WXMArrayExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/24.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

extension Array {

    /**< 判断是否可用 */
    var available: Bool {
        get {
            let tempArray = self as? [AnyClass]
            return tempArray != nil && tempArray?.count ?? 0 > 0
        }
    }

    /**< 获取索引对象  */
    public func objectIdxSafe_k(index: Int) -> Element? {
        if (index >= 0 && index < count) {
            return self[index]
        }
        return nil
    }
    
    public func noNil_k(_ index: Int) -> Element {
        if (index >= 0 && index < count) {
            return self[index]
        }
        return "" as! Element
    }
}

extension Array where Element: Comparable {
    
    /**< 获取对象索引  */
    public func objectToIndex_k(object: Element) -> Int {
        let array: [Element] = self
        for (index, value) in array.enumerated() {
            if value == object { return index }
        }
        return -1
    }
    
    /**< 删除对象  */
    public mutating func removeObj_k(object: Element) {
        let index = objectToIndex_k(object: object)
        if count > index {
            remove(at: index)
        }
    }

}
