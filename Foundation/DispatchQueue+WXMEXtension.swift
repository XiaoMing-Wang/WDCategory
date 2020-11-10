//
//  DispatchQueue+WXMEXtension.swift
//  HiTalk
//
//  Created by imMac on 2020/11/2.
//  Copyright © 2020 hitalk. All rights reserved.
//

import Foundation

extension DispatchQueue {

    private static var _onceTracker = [String]()
    public class func once(token: String, block: @escaping () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }
}
