//
//  UITableViewCell+WXMExtension.swift
//  im-client
//
//  Created by wq on 2020/6/15.
//  Copyright © 2020 IM. All rights reserved.
//
import UIKit
import Foundation

extension UITableViewCell {

    class func nib() -> UINib? {
        if let className = NSStringFromClass(self).components(separatedBy: ".").last {
            return UINib(nibName: className, bundle: nil)
        }
        return nil
    }

}
