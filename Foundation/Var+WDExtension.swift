//
//  WXMBasedVariableExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/25.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

extension Int {
    
    /**< floatValue */
    var floatValue: Float {
        get {
            let value = self
            return Float(value)
        }
    }

    /**< stringValue */
    var stringValue: String {
        get {
            let value = self
            return String(value)
        }
    }
}

extension Int64 {
    
    /**< floatValue */
    var floatValue: Float {
        get {
            let value = self
            return Float(value)
        }
    }

    /**< stringValue */
    var stringValue: String {
        get {
            let value = self
            return String(value)
        }
    }
}

extension Float {
    
    /**< intValue */
    var intValue: Int {
        get {
            let value = self
            return Int(value)
        }
    }

    /**< stringValue */
    var stringValue: String {
        get {
            let value = self
            return String(value)
        }
    }

    /**< cgFloat */
    var cgFloat: CGFloat {
        get {
            let value = self
            return CGFloat(value)
        }
    }
    
}


extension CGFloat {

    /**< float  */
    var float: Float {
        get {
            let value = self
            return Float(value)
        }
    }
    
    /**< int  */
    var int: Int {
        get {
            let value = self
            return Int(value)
        }
    }

    /**< int */
    var int64: Int64 {
        get {
            let value = self
            return Int64(value)
        }
    }
    
}
