//
//  UIBarButtonItem+WXMExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/28.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

fileprivate var wrapAction: Void?
fileprivate let itemFont: UIFont = .systemFont(ofSize: 16.5)
fileprivate let titleTinColor: UIColor = .black
extension UIBarButtonItem {

    /** 自定义文字 */
    convenience init(title: String, tintColor: UIColor, action: @escaping () -> Void) {
        let attributes = [NSAttributedString.Key.font: itemFont]
        let expectedSize = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        let expectedRect = NSString(string: title).boundingRect(
            with: expectedSize,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )
        
        let customView = UIButton(frame: CGRect(x: 0, y: 0, width: expectedRect.width, height: 40))
        customView.setTitle(title, for: .normal)
        customView.setTitleColor(tintColor, for: .normal)
        customView.contentHorizontalAlignment = .right
        customView.titleLabel?.font = itemFont
        customView.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        customView.setEnlargeEdgeTop_k(top: 15, bottom: 15, left: 15, right: 15)

        self.init(customView: customView)
        customView.addTarget(self, action: #selector(wrapEvent(_:)), for: .touchUpInside)
        objc_setAssociatedObject(self, &wrapAction, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /** 自定义图片 */
    convenience init(rightImage: String, action: @escaping () -> Void) {
        self.init(imgName: rightImage, left: false, action: action)
    }

    convenience init(leftImage: String, action: @escaping () -> Void) {
        self.init(imgName: leftImage, action: action)
    }

    private convenience init(imgName: String, left: Bool = true, action: @escaping () -> Void) {
        let image = UIImage(named: imgName)
        let imageSize = image?.size ?? .zero
        let imageView = UIImageView(image: image)
        let imageX = left ? 0.0 : 60 - imageSize.width
        let oringin = CGPoint(x: imageX, y: (44 - imageSize.height) / 2.0)

        imageView.frame = CGRect(origin: oringin, size: imageSize)
        let customView = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        
        self.init(customView: customView)
        customView.addSubview(imageView)
        customView.addTarget(self, action: #selector(wrapEvent(_:)), for: .touchUpInside)
        objc_setAssociatedObject(self, &wrapAction, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /** 自定义文字和图片 左边 */
    convenience init(title: String, imgName: String, action: @escaping () -> Void) {
        let image = UIImage(named: imgName)
        let rect = CGRect(x: 0, y: 0, width: image?.size.width ?? 0, height: image?.size.height ?? 0)
        let customView = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))

        let icon = UIImageView(frame: rect)
        icon.image = image
        icon.center = CGPoint(x: icon.center.x, y: customView.frame.size.height / 2)

        let left = icon.frame.origin.x + icon.frame.size.width + 1.0
        let width = icon.frame.size.width;
        let titleLabel = UILabel(frame: CGRect(x: left, y: 0, width: 60 - width, height: 40))
        titleLabel.center = CGPoint(x: titleLabel.center.x, y: customView.frame.size.height / 2 + 0.6)
        titleLabel.text = title
        titleLabel.font = itemFont
        titleLabel.textColor = titleTinColor

        customView.setEnlargeEdgeTop_k(top: 15, bottom: 15, left: 15, right: 15)
        customView.addSubview(icon)
        customView.addSubview(titleLabel)

        self.init(customView: customView)
        customView.addTarget(self, action: #selector(wrapEvent(_:)), for: .touchUpInside)
        objc_setAssociatedObject(self, &wrapAction, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    @objc fileprivate func wrapEvent(_ sender: UIButton) {
        let closure = objc_getAssociatedObject(self, &wrapAction) as? () -> Void
        closure?()
    }

}

