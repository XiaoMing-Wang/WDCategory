//
//  WXMUIViewLieExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/25.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

private var onceTap :Void?
private var doubleTap :Void?
extension UIView {
    
    /** 在window中的位置 */
    func locationWithWindow_k() -> CGRect {
        guard let window = UIApplication.shared.delegate?.window else { return .zero }
        return self.convert(self.bounds, to: window)
    }

    /** 单击Selector */
    func tappedWithTarget_k(target: Any, selector: Selector) {
        let gesture = UITapGestureRecognizer(target: target, action: selector)
        gesture.delegate = self as? UIGestureRecognizerDelegate
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1

        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
    }

    /** 截图  */
    func makeImage_k() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }

    /** 单击block */
    @discardableResult
    func addOnceTappedWithCallback_k(callback: @escaping () -> ()) -> UITapGestureRecognizer {
        let gesture = addTapGesture(taps: 1, touches: 1, selector: #selector(tappedEvent(gesture:)))
        objc_setAssociatedObject(self, &onceTap, callback, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return gesture
    }

    /** 双击block */
    @discardableResult
    func addDoubleTappedWithCallback_k(callback: @escaping () -> ()) -> UITapGestureRecognizer {
        let gesture = addTapGesture(taps: 2, touches: 1, selector: #selector(tappedEvent(gesture:)))
        objc_setAssociatedObject(self, &doubleTap, callback, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return gesture
    }

    ///上下居中
    func venicalSet_k(above: UIView?, nether: UIView?, interval: CGFloat) {
        if (above == nil || nether == nil || self.frame.size.height == 0) { return }

        let totalHeight = self.frame.size.height
        let totalInterval = totalHeight - above!.frame.size.height - nether!.frame.size.height
        let topAbove = (totalInterval - interval) / 2.0

        var rectAbove = above!.frame;
        rectAbove.origin.y = topAbove;
        above!.frame = rectAbove;

        var rectNether = nether!.frame;
        rectNether.origin.y = totalHeight - topAbove - nether!.frame.size.height;
        nether!.frame = rectNether;
    }
    
    ///左右居中
    func horizontalSet_k(above: UIView?, nether: UIView?, interval: CGFloat) {
        if (above == nil || nether == nil || self.frame.size.height == 0) { return }

        let totalWidth = self.frame.size.width
        let totalInterval = totalWidth - above!.frame.size.width - nether!.frame.size.width
        let leftAbove = (totalInterval - interval) / 2.0

        var rectAbove = above!.frame;
        rectAbove.origin.x = leftAbove;
        above!.frame = rectAbove;

        var rectNether = nether!.frame;
        rectNether.origin.x = totalWidth - leftAbove - nether!.frame.size.width;
        nether!.frame = rectNether;
    }

    ///渐现动画
    func fadeAnimation_k(duration: CGFloat = 0.5) {
        let transition = CATransition()
        transition.duration = CFTimeInterval(duration)
        transition.type = .fade
        transition.subtype = .fromRight;
        self.layer.add(transition, forKey: "fadeAnimation")
    }
    
    ///翻页
    func pageCurlAnimation_k(duration: CGFloat = 0.5) {
        let transition = CATransition()
        transition.duration = CFTimeInterval(duration)
        transition.type = CATransitionType(rawValue: "pageCurl")
        transition.subtype = .fromLeft
        self.layer.add(transition, forKey: "pageCurl")
    }
    
    /** 消失动画 */
    func disappearAnimation_k(duration: CGFloat = 0.5) {
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.alpha = 0
        }) { $0 ? self.removeFromSuperview() : nil }
    }
  
    /** 点击事件 */
    @objc fileprivate func tappedEvent(gesture: UITapGestureRecognizer) {
        var callback: (() -> ())? = nil
        if gesture.numberOfTapsRequired == 1 {
            callback = objc_getAssociatedObject(self, &onceTap) as? (() -> ())
        }

        if gesture.numberOfTapsRequired == 2 {
            callback = objc_getAssociatedObject(self, &doubleTap) as? (() -> ())
        }

        if callback != nil { callback!() }
    }

    /** 实例化手势 */
    fileprivate func addTapGesture(taps: Int, touches: Int, selector: Selector) -> UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer(target: self, action: selector)
        gesture.delegate = self as? UIGestureRecognizerDelegate
        gesture.numberOfTapsRequired = taps
        gesture.numberOfTouchesRequired = touches

        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
        return gesture
    }

    /** snp */
    func aSup(_ supview: UIView) -> Self {
        supview.addSubview(self)
        return self
    }

    /** xib */
    class func xib() -> UIView? {
        guard let className = String(NSStringFromClass(self)).components(separatedBy: ".").last else {
            return nil
        }
        let nib = UINib(nibName: className, bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as? UIView
    }

    /** 任意角画圆 */
    func drawSemicircleRectCorner(rectCorner: UIRectCorner, cornerRadius: CGFloat) {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: rectCorner, cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

    /** 圆角边框 */
    func drawSemicircleRectCorner(cornerRadius: CGFloat, lineColor: UIColor) {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

}
