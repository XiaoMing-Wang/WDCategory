//
//  WQResponderExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/24.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

/** 响应链传递 消息会沿着响应链像父视图传递包括controller 某一层实现了该方法就可以拦截到该消息 不要多次拦截 */
extension UIResponder {

    /** 参数是字符串 */
    @objc func routerEvent(_ event: String, object aObject: Any? = nil) {
        next?.routerEvent(event, object: aObject)
        next?.routerEventAny(event, object: aObject)
    }

    /** 参数是枚举 */
    @objc func routerEventAny(_ event: Any, object aObject: Any? = nil) {
        next?.routerEventAny(event, object: aObject)
    }

}
