//
//  WXMUIButtonExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/26.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

fileprivate var topKey: Void?
fileprivate var bottomKey: Void?
fileprivate var leftKey: Void?
fileprivate var rightKey: Void?
fileprivate var touchKey: Void?
fileprivate var buttonTextKey: Void?
fileprivate var indicatorKey: Void?

extension UIButton {

    ///normal
    var normalImage: UIImage? {
        set { setImage(newValue, for: .normal) }
        get { return image(for: .normal) }
    }
    
    var normalBackgroundImage: UIImage? {
        set { setBackgroundImage(newValue, for: .normal) }
        get { return backgroundImage(for: .normal) }
    }
    
    var normalTitle: String? {
        get { return title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    var normalTitleColor: UIColor? {
        get { return titleColor(for: .normal) }
        set { setTitleColor(newValue, for: .normal) }
    }
    

    ///selected
    var selectedImage: UIImage? {
        set { setImage(newValue, for: .selected) }
        get { return image(for: .selected) }
    }
    
    var selectedBackgroundImage: UIImage? {
        set { setBackgroundImage(newValue, for: .selected) }
        get { return backgroundImage(for: .selected) }
    }
    
    var selectedTitle: String? {
        get { return title(for: .selected) }
        set { setTitle(newValue, for: .selected) }
    }
    
    var selectedTitleColor: UIColor? {
        get { return titleColor(for: .selected) }
        set { setTitleColor(newValue, for: .selected) }
    }

    ///disabled
    var disabledImage: UIImage? {
        set { setImage(newValue, for: .disabled) }
        get { return image(for: .disabled) }
    }
    
    var disabledBackgroundImage: UIImage? {
        set { setBackgroundImage(newValue, for: .disabled) }
        get { return backgroundImage(for: .disabled) }
    }
           
    var disabledTitle: String? {
        get { return title(for: .disabled) }
        set { setTitle(newValue, for: .disabled) }
    }

    var disabledTitleColor: UIColor? {
        get { return titleColor(for: .disabled) }
        set { setTitleColor(newValue, for: .disabled) }
    }

    /**< 标题大小 */
    var titleFont: UIFont? {
        get { return titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
    
    /**< 添加手势 */
    func setTarget_k(target: Any, action: Selector) {
        self.addTarget(target, action: action, for: .touchUpInside)
    }

    /**< 点击闭包 */
    func setClosureTouchUpInside_k(closure: @escaping () -> Void) {
        self.addTarget(self, action: #selector(callActionClosure(sender:)), for: .touchUpInside)
        objc_setAssociatedObject(self, &touchKey, closure, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /**< 扩大点击范围 */
    func setEnlargeEdgeTop_k(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        objc_setAssociatedObject(self, &topKey, top, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &bottomKey, bottom, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &leftKey, left, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &rightKey, right, .OBJC_ASSOCIATION_COPY_NONATOMIC);
    }

    /**< 显示菊花 */
    func showIndicator_k() {
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        indicator.startAnimating()

        let currentText = titleLabel?.text
        objc_setAssociatedObject(self, &buttonTextKey, currentText, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &indicatorKey, indicator, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        isUserInteractionEnabled = false
        setTitle("", for: .normal)
        addSubview(indicator)
    }

    /**< 隐藏菊花 */
    func hideIndicator_k() {
        isUserInteractionEnabled = true
        let indicator = objc_getAssociatedObject(self, &indicatorKey) as? UIActivityIndicatorView
        let currentText = objc_getAssociatedObject(self, &buttonTextKey) as? String
        indicator?.removeFromSuperview()
        setTitle(currentText, for: .normal)
    }

    /**< 设置图片字体上下对齐 */
    func alineTextAlignment_k(space: CGFloat) {
        let imageSize = self.imageView?.frame.size
        var titleSize = self.titleLabel?.frame.size
        if imageSize == nil || titleSize == nil { return }

        let text = self.titleLabel?.text ?? ""
        let att = [NSAttributedString.Key.font: self.titleLabel?.font!]
        let textSize = NSString(string: text).size(withAttributes: att as [NSAttributedString.Key: Any])
        let frameSize = CGSize(width: textSize.height, height: textSize.height)
        if titleSize!.width + 0.5 < frameSize.width { titleSize!.width = frameSize.width }
        let totalHeight = (imageSize!.height + titleSize!.height + space)

        imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize!.height),
            left: 0,
            bottom: 0,
            right: -titleSize!.width
        )

        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize!.width,
            bottom: -(totalHeight - titleSize!.height),
            right: 0
        )
    }
    
    fileprivate func enlargedRect() -> CGRect {
        let top = objc_getAssociatedObject(self, &topKey) as? CGFloat ?? -1
        let bottom = objc_getAssociatedObject(self, &bottomKey) as? CGFloat ?? -1
        let left = objc_getAssociatedObject(self, &leftKey) as? CGFloat ?? -1
        let right = objc_getAssociatedObject(self, &rightKey) as? CGFloat ?? -1

        if top != -1 && bottom != -1 && left != -1 && right != -1 {
            let x = bounds.origin.x - left
            let y = bounds.origin.y - top
            let w = bounds.size.width + left + right
            let h = bounds.size.height + top + bottom
            return CGRect(x: x, y: y, width: w, height: h)
        } else {
            return bounds
        }
    }

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let rect = enlargedRect()
        if rect.equalTo(bounds) { return super.hitTest(point, with: event) }
        return rect.contains(point) ? self : nil
    }

    @objc fileprivate func callActionClosure(sender: UIButton) {
        let closure = objc_getAssociatedObject(self, &touchKey) as? () -> Void
        closure?()
    }

}
