//
//  WXMUIImageExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/27.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation
import Accelerate

extension UIImage {
    
    /// 颜色画图片
    class func imageFromColor_k(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }

    /// 裁剪图片的一部分
    func tailorImageRect(rect: CGRect) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let sourceImageRef = self.cgImage else { return nil }
        guard let newCGImage = sourceImageRef.cropping(to: rect) else { return nil }
        return UIImage(cgImage: newCGImage)
    }

    /// 拉伸
    func imageStretching_k() -> UIImage {
        return self.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    }

    /** 获取重回比例 */
    class func scaleImage_k(image: UIImage, imageLength: CGFloat = 1280) -> UIImage? {
        let width = image.size.width
        let height = image.size.height
        var newWidth: CGFloat = width
        var newHeight: CGFloat = height

        if (width > imageLength || height > imageLength) {
            if (width > height) {
                newWidth = imageLength;
                newHeight = newWidth * height / width;
            } else if(height > width) {
                newHeight = imageLength;
                newWidth = newHeight * width / height;
            } else {
                newWidth = imageLength;
                newHeight = imageLength;
            }
        }
        return resizeImage_k(image: image, newSize: CGSize(width: newWidth, height: newHeight))
    }

    /** 获得指定size的图片 */
    class func resizeImage_k(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /** 获取启动图 */
    func getLaunchImage_k() -> UIImage? {
        let viewOrientation = "Portrait"
        var launchImageName: String?

        let imagesArray = Bundle.main.infoDictionary!["UILaunchImages"]
        let viewsize = UIScreen.main.bounds.size
        if imagesArray == nil { return nil }
        for dict: [String: String] in imagesArray as! Array {
            let imageSize = NSCoder.cgSize(for: dict["UILaunchImageSize"]!)
            if imageSize.equalTo(viewsize), viewOrientation == dict["UILaunchImageOrientation"]! as String {
                launchImageName = dict["UILaunchImageName"] ?? ""
            }
        }
        return UIImage(named: launchImageName ?? "")
    }
    
    /** 绘制遮罩图片 */
    class func drawRounded_k(_ radius: CGFloat, rectSize: CGSize, fillColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rectSize, false, UIScreen.main.scale)
        let currentContext = UIGraphicsGetCurrentContext()

        let bezierPath = UIBezierPath()
        let hLeftUpPoint = CGPoint(x: radius, y: 0);
        let hRightUpPoint = CGPoint(x: rectSize.width - radius, y: 0);
        let hLeftDownPoint = CGPoint(x: radius, y: rectSize.height);

        let vLeftUpPoint = CGPoint(x: 0, y: radius);
        let vRightDownPoint = CGPoint(x: rectSize.width, y: rectSize.height - radius);

        let centerLeftUp = CGPoint(x: radius, y: radius);
        let centerRightUp = CGPoint(x: rectSize.width - radius, y: radius);
        let centerLeftDown = CGPoint(x: radius, y: rectSize.height - radius);
        let centerRightDown = CGPoint(x: rectSize.width - radius, y: rectSize.height - radius);

        bezierPath.move(to: hLeftUpPoint)
        bezierPath.addLine(to: hRightUpPoint)
        bezierPath.addArc(
            withCenter: centerRightUp,
            radius: radius,
            startAngle: (CGFloat(Double.pi * 3 / 2)),
            endAngle: (CGFloat(Double.pi * 2)),
            clockwise: true
        )
        
        bezierPath.addLine(to: vRightDownPoint)
        bezierPath.addArc(
            withCenter: centerRightDown,
            radius: radius,
            startAngle: 0,
            endAngle: (CGFloat(Double.pi / 2)),
            clockwise: true
        )
        
        bezierPath.addLine(to: hLeftDownPoint)
        bezierPath.addArc(
            withCenter: centerLeftDown,
            radius: radius,
            startAngle: (CGFloat(Double.pi / 2)),
            endAngle: (CGFloat(Double.pi)),
            clockwise: true
        )
        
        bezierPath.addLine(to: vLeftUpPoint)
        bezierPath.addArc(
            withCenter: centerLeftUp,
            radius: radius,
            startAngle: (CGFloat(Double.pi)),
            endAngle: (CGFloat(Double.pi * 3 / 2)),
            clockwise: true
        )
        
        bezierPath.addLine(to: hLeftUpPoint)
        bezierPath.close()

        bezierPath.move(to: .zero)
        bezierPath.addLine(to: CGPoint(x: 0, y: rectSize.height))
        bezierPath.addLine(to: CGPoint(x: rectSize.width, y: rectSize.height))
        bezierPath.addLine(to: CGPoint(x: rectSize.width, y: 0))
        bezierPath.addLine(to: .zero)
        bezierPath.close()
        
        fillColor.setFill()
        bezierPath.fill()

        guard let context = currentContext else { return nil }
        context.drawPath(using: CGPathDrawingMode.fillStroke);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

