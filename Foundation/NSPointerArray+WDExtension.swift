//
//  NSPointerArray+WXMExtension.swift
//  im-client
//
//  Created by imMac on 2020/7/22.
//  Copyright © 2020 IM. All rights reserved.
//

import UIKit

extension NSPointerArray {

    func addObject(_ object: AnyObject?) {
        guard let strongObject = object else { return }
        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        addPointer(pointer)
    }

    func insertObject(_ object: AnyObject?, at index: Int) {
        guard index < count, let strongObject = object else { return }
        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        insertPointer(pointer, at: index)
    }

    func replaceObject(at index: Int, withObject object: AnyObject?) {
        guard index < count, let strongObject = object else { return }
        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        replacePointer(at: index, withPointer: pointer)
    }

    func object(at index: Int) -> AnyObject? {
        if let pointer = self.pointer(at: index) {
            return Unmanaged<AnyObject>.fromOpaque(pointer).takeUnretainedValue()
        }
        return nil
    }

    func removeObject(at index: Int) {
        guard index < count else { return }
        removePointer(at: index)
    }
}

