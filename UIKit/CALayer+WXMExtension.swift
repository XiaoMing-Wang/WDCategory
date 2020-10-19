//
//  CALayer+WXMExtension.swift
//  im-client
//
//  Created by wq on 2020/6/10.
//  Copyright © 2020 IM. All rights reserved.
//
import UIKit
import Foundation

extension CALayer {

    /// 起点 x
    var x: CGFloat {
        get {
            return frame.origin.x
        }

        set {
            frame = CGRect(x: newValue, y: y, width: width, height: height)
        }
    }

    /// 起点 y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        
        set {
            frame = CGRect(x: x, y: newValue, width: width, height: height)
        }
    }
    
    /// 宽
    var width: CGFloat {
        get {
            return frame.size.width
        }
        
        set {
            frame = CGRect(x: x, y: y, width: newValue, height: height)
        }
    }

    /// 高
    var height: CGFloat {
        get {
            return frame.size.height
        }
        
        set {
            frame = CGRect(x: x, y: y, width: width, height: newValue)
        }
    }

    /// 起点 left
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        
        set {
            frame = CGRect(x: newValue, y: y, width: width, height: height)
        }
    }
    
    /// 起点 top
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        
        set {
            frame = CGRect(x: x, y: newValue, width: width, height: height)
        }
    }
    
    /// 右
    var right: CGFloat {
        get {
            return x + width
        }
        
        set {
            x = newValue - width
        }
    }
    
    /// 下
    var bottom: CGFloat {
        get {
            return y + height
        }
        
        set {
            y = newValue - height
        }
    }
    
    /// 中心 x
    var centerX: CGFloat {
        get {
            return position.x
        }
        
        set {
            position = CGPoint(x: newValue, y: position.y)
        }
    }

    /// 中心 y
    var centerY: CGFloat {
        get {
            return position.y
        }
        
        set {
            position = CGPoint(x: position.x, y: newValue)
        }
    }

    /// origin
    var origin: CGPoint {
        get {
            return frame.origin
        }
        
        set {
            frame = CGRect(x: newValue.x, y: newValue.y, width: width, height: height)
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        
        set {
            frame = CGRect(x: x, y: y, width: newValue.width, height: newValue.height)
        }
    }
        
    func layoutCenterX(_ referenceView : UIView) {
        centerX = referenceView.centerX
    }
    
    func layoutCenterY(_ referenceView : UIView) {
        centerY = referenceView.centerY
    }
    
    func layoutCenterXY(_ referenceView : UIView) {
        centerX = referenceView.centerX
        centerY = referenceView.centerY
    }
        
    /// 右边
    func layoutReferenceRight(_ referenceView : UIView, _ offset : CGFloat) {
        let totalWidth = referenceView.left - left
        if (width == 0) {
            width = totalWidth - offset
        } else {
            right = referenceView.left - offset
        }
    }

    /// 下边
    func layoutReferenceBottom(_ referenceView: UIView, _ offset: CGFloat) {
        let totalHeight = referenceView.top - top
        if (height == 0) {
            height = totalHeight - offset
        } else {
            bottom = referenceView.top - offset
        }
    }

}
