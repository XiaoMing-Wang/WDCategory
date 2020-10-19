//
//  WXMNotificationCenterExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/25.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

var notificationKey :Void?
extension NotificationCenter {

    /// 监听
    public func addObserver_k(
        observer: UIViewController,
        name: String,
        object: Any?,
        usingBlock: @escaping (Notification) -> Void) {

        /// object全部绑定在ViewController ios 11以后可以不需要释放观察者
        let object = NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: name),
            object: object,
            queue: nil,
            using: usingBlock
        )

        let dict = objc_getAssociatedObject(observer, &notificationKey)
        var dictionary = dict as? Dictionary<String, Any> ?? [:]
        dictionary[name] = object
        objc_setAssociatedObject(observer, &notificationKey, dictionary, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
}

func wk_addNotificationClosure (
    _ observer: UIViewController,
    name: String,
    object: Any? = nil,
    usingBlock: @escaping (Notification) -> Void) {

    NotificationCenter.default.addObserver_k(
        observer: observer,
        name: name,
        object: object,
        usingBlock: usingBlock
    )
}

func wk_addNotificationSEL(
    observer: Any,
    selector: Selector,
    name: String,
    object: Any? = nil) {

    NotificationCenter.default.addObserver(
        observer,
        selector: selector,
        name: NSNotification.Name(rawValue: name),
        object: object
    )
}

func wk_postNotification(_ name: String, object: Any? = nil) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: object)
}
