//
//  WXMUIViewControllerExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/25.
//  Copyright © 2020 wq. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    ///   显示弹窗
    ///   - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - cancle: 取消按钮标题
    func showAlertViewController_k(title: String? = nil, message: String? = nil, cancle: String?) {
        showAlertViewController_k(
            title: title,
            message: message,
            cancle: cancle,
            otherAction: nil,
            complete: nil
        )
    }
    
    
    ///   显示弹窗
    ///   - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - cancle: 取消按钮标题
    ///   - otherAction: 其他标题
    ///   - complete: 回调
    @discardableResult
    func showAlertViewController_k(
        title: String?,
        message: String? = nil,
        cancle: String? = "确定",
        otherAction: [String]? = nil,
        complete: ((Int) -> Void)?) -> UIAlertController {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancle, style: .cancel) { (action) in
            complete?(0)
        })
        
        if let actions = otherAction {
            for (index, otherString) in actions.enumerated() {
                alert.addAction(UIAlertAction(title: otherString, style: .default) { (action) in
                    complete?(index + 1)
                })
            }
        }
        
        present(alert, animated: true, completion: nil)
        return alert
    }
    
  
    class func currentViewController(_ controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let presented = controller?.presentedViewController {
            return currentViewController(presented)
        }

        if let nav = controller as? UINavigationController {
            return currentViewController(nav.topViewController)
        }
        if let tab = controller as? UITabBarController {
            return currentViewController(tab.selectedViewController)
        }
        return controller
    }

    func presentFull_k(_ viewControllerToPresent: UIViewController) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: true, completion: nil)
    }

}

/// 导航控制器
extension UINavigationController {

    /// 设置导航栏透明
    func setNavigationBarColor_k(color: UIColor, alpha: CGFloat = 1) {
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        let colorAlp = color.withAlphaComponent(alpha)
        navigationBar.setBackgroundImage(colorConversionImage(color: colorAlp), for: .default)
    }

    /// 删除某个子控制器
    func removeSubViewController_k(vcName: String) {
        var subControllers: [UIViewController] = []
        let currentVC = viewControllers
        if currentVC.count <= 1 { return }

        for subVC in currentVC {
            let aClass = type(of: subVC).description().components(separatedBy: ".").last
            if aClass != vcName || subVC == visibleViewController {
                subControllers.append(subVC)
            }
        }
        setViewControllers(subControllers, animated: false)
    }
        
    /// 删除子控制器数组
    func removeSubViewControllerArray_k(controllers: Array<String>) {
        objc_sync_enter(self)
        var subControllers: [UIViewController] = []
        let currentVC = self.viewControllers
        if currentVC.count <= 1 { return }

        for subVC in currentVC {
            let aClass = type(of: subVC).description().components(separatedBy: ".").last ?? ""
            if controllers.contains(aClass) == false || subVC == self.visibleViewController {
                subControllers.append(subVC)
            }
        }
        self.setViewControllers(subControllers, animated: false)
        objc_sync_exit(self)
    }

    /// 跳到某个页面
    func popToViewControllerName_k(vcName: String, animation: Bool = true) {
        let currentVC = viewControllers
        for subVC in currentVC {
            let aClass = type(of: subVC).description().components(separatedBy: ".").last
            if aClass == vcName {
                popToViewController(subVC, animated: animation)
                break
            }
        }
    }
    
    /// 判断是否包含某个页面
    func haveChildViewController_k(vcName: String) -> Bool {
        let currentVC = viewControllers
        for subVC in currentVC {
            let aClass = type(of: subVC).description().components(separatedBy: ".").last
            if aClass == vcName {
                return true
            }
        }
        return false
    }
    
    /// 插入某个页面
    func insertViewController_k(controller: UIViewController, index: Int) {
        var currentVC = viewControllers
        if index >= currentVC.count { return }
        currentVC.insert(controller, at: index)
        controller.hidesBottomBarWhenPushed = true
        viewControllers = currentVC
    }
    
    /// 回到tab的第N个页面 ios14bug
    func popRootViewConlroller_k() {
        topViewController?.hidesBottomBarWhenPushed = false
        popToRootViewController(animated: true)
    }
}

extension UIViewController {
    
    /** 初始化调用 */
    public class func initializeMethod() {
//        let originalSEL = Selector.init(("dealloc"))
//        let swizzledSEL = #selector(swizzled_deinit)
//        swizzlingForClass(UIViewController.self, originalSEL: originalSEL, swizzledSEL: swizzledSEL)
    }
    
    /** 被替换的方法 */
    @objc func swizzled_deinit() {

        #if DEBUG
        let file = type(of: self)
        print("\(file) deinit 26行------>: \(file) 被释放了😇😇😇😇😇😇😇😇")
        #endif
        
        guard let dic = objc_getAssociatedObject(self, &notificationKey) else { return }
        guard let dictionry = dic as? [String: Any] else { return }
        for (_, value) in dictionry {
            NotificationCenter.default.removeObserver(value)
        }
    }
    
    /** 替换方法 */
    static fileprivate func swizzlingForClass(_ forClass: AnyClass, originalSEL: Selector, swizzledSEL: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSEL)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSEL)
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        
        
        if class_addMethod(forClass, originalSEL, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            
            class_replaceMethod(forClass,
                                swizzledSEL,
                                method_getImplementation(originalMethod!),
                                method_getTypeEncoding(originalMethod!))
            
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
        
    
}

/// 颜色转图片
func colorConversionImage(color: UIColor) -> UIImage {
    let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)

    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)

    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage.init() }
    UIGraphicsEndImageContext();
    return image
}
