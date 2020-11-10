//
//  WXMUIViewLieExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/25.
//  Copyright © 2020 wq. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    /**< 起点 x */
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        
        set {
            frame = CGRect(x: newValue, y: y, width: width, height: height)
        }
    }
    
    /**< 起点 y */
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        
        set {
            frame = CGRect(x: x, y: newValue, width: width, height: height)
        }
    }
    
    /**< 宽 */
    var width: CGFloat {
        get {
            return frame.size.width
        }
        
        set {
            frame = CGRect(x: x, y: y, width: newValue, height: height)
        }
    }

    /**< 高 */
    var height: CGFloat {
        get {
            return frame.size.height
        }
        
        set {
            frame = CGRect(x: x, y: y, width: width, height: newValue)
        }
    }

    /**< 起点 left */
    var left: CGFloat {
        get {
            return frame.origin.x
        }

        set {
            frame = CGRect(x: newValue, y: y, width: width, height: height)
        }
    }
    
    /**< 起点 top */
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        
        set {
            frame = CGRect(x: x, y: newValue, width: width, height: height)
        }
    }
    
    /**< 右 */
    var right: CGFloat {
        get {
            return x + width
        }
        
        set {
            x = newValue - width
        }
    }
    
    /**< 下 */
    var bottom: CGFloat {
        get {
            return y + height
        }
        
        set {
            y = newValue - height
        }
    }
    
    /**< 中心 x */
    var centerX: CGFloat {
        get {
            return center.x
        }
        
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
    }

    /**< 中心 y */
    var centerY: CGFloat {
        get {
            return center.y
        }
        
        set {
            center = CGPoint(x: center.x, y: newValue)
        }
    }

    /**< origin */
    var origin: CGPoint {
        get {
            return frame.origin
        }
        
        set {
            frame = CGRect(x: newValue.x, y: newValue.y, width: width, height: height)
        }
    }
    
    /**< size */
    var size: CGSize {
        get {
            return frame.size
        }
        
        set {
            frame = CGRect(x: x, y: y, width: newValue.width, height: newValue.height)
        }
    }
    
    /**< 右 */
    var layoutRight: CGFloat {
        get {
            return right
        }
        
        set {
            var suprWidth = UIScreen.main.bounds.size.width
            if (superview != nil) {
                suprWidth = superview!.frame.size.width
            }
            
            if (width == 0) {
                width = suprWidth - left - newValue
            } else {
                right = suprWidth - newValue
            }

        }
    }
    
    /**< 下 */
    var layoutBottom: CGFloat {
        get {
            return bottom
        }
        
        set {
            var suprHeight = UIScreen.main.bounds.size.height
            if (self.superview != nil) {
                suprHeight = self.superview!.frame.size.height
            }
            
            if (height == 0) {
                height = suprHeight - top - newValue
            } else {
                bottom = suprHeight - newValue
            }
            
        }
    }
    
    /**< 圆角 */
    var layoutCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }

    func layoutCenterX(_ referenceView: UIView) {
        self.centerX = referenceView.width / 2
    }

    func layoutCenterY(_ referenceView: UIView) {
        self.centerY = referenceView.height / 2
    }

    func layoutCenterXY(_ referenceView: UIView) {
        self.centerX = referenceView.width / 2
        self.centerY = referenceView.height / 2
    }
        
    /**< 右边 */
    func layoutReferenceRight(_ referenceView : UIView, _ offset : CGFloat) {
        let totalWidth = referenceView.left - left
        if (width == 0) {
            width = totalWidth - offset
        } else {
            right = referenceView.left - offset
        }
    }
    
    /**< 下边 */
    func layoutReferenceBottom(_ referenceView: UIView, _ offset: CGFloat) {
        let totalHeight = referenceView.top - top
        if (height == 0) {
            height = totalHeight - offset
        } else {
            bottom = referenceView.top - offset
        }
    }
    
}
