//
//  UILabel+WXMExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/27.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

/// 设置最大宽度
extension UILabel {
    
    var maxShowWidth: CGFloat {
        get {
            return frame.size.width
        }
        
        set {
            if self.frame.size.width > newValue {
                let origin = frame.origin
                var frame = self.frame
                frame.size.width = newValue
                frame.origin = origin
                self.frame = frame
                self.lineBreakMode = .byTruncatingTail
            }
        }
    }

    ///行与行间隔
    var spaceLine: CGFloat {
        get {
            return 0.0
        }

        set {

            let origin = self.frame.origin
            let text = self.text ?? ""
            let attributed = NSMutableAttributedString(string: text)
            let range = NSRange(location: 0, length: text.count)

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = newValue
            attributed.addAttributes([.paragraphStyle: paragraphStyle], range: range)

            self.attributedText = attributed
            self.sizeToFit()
            
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }

    ///列与列间隔
    var spaceColumn: CGFloat {
        get {
            return 0.0
        }

        set {

            let origin = self.frame.origin
            let text = self.text ?? ""
            let attributesDic = [NSAttributedString.Key.kern: newValue]
            let attributed = NSMutableAttributedString(string: text, attributes: attributesDic)
            let range = NSRange(location: 0, length: text.count)

            let paragraphStyle = NSMutableParagraphStyle()
            attributed.addAttributes([.paragraphStyle: paragraphStyle], range: range)

            self.attributedText = attributed
            self.sizeToFit()

            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
    
}

