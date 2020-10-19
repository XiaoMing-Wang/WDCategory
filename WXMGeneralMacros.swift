//
//  WXMGeneralMacros.swift
//  SwiftDemo2
//
//  Created by wq on 2020/4/26.
//  Copyright © 2020 wxm. All rights reserved.
//

import UIKit
import Foundation

let kIPhoneX = kJudgeIPhoneX()

/** 屏幕frame */
let kSRect = UIScreen.main.bounds
let kEdgeRect = CGRect(x: 0, y: kBarHeight, width: kSWidth, height: (kSHeight - kBarHeight))

/** 导航栏高度 安全高度 */
let kBarRemainHeight: CGFloat = 44.0
let kBarHeight: CGFloat = (kBarRemainHeight + kStatusBarHeight())
let kSafeHeight: CGFloat = kSafeBottom()
let kTabbarHeight: CGFloat = 49.0

/**< 屏幕宽高 */
let kSWidth: CGFloat = UIScreen.main.bounds.size.width
let kSHeight: CGFloat = UIScreen.main.bounds.size.height
let kSScale: CGFloat = UIScreen.main.scale

/**< 获取系统版本 */
let kIOS_Version: CGFloat = CGFloat((UIDevice.current.systemVersion as NSString).floatValue)
let kCurrentSystemVersion: String = UIDevice.current.systemVersion;

/**< 获取当前语言 */
let kCurrentLanguage: String = NSLocale.preferredLanguages.first!

/**< Library 路径 */
let kLibraryboxPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .allDomainsMask, true).first

/**< Window AppDelegate 通知中心和UserDefaults */
let kWindow = UIApplication.shared.delegate?.window
let kKeyWindow = UIApplication.shared.keyWindow
let kAppDelegate = UIApplication.shared.delegate
let kNotificationCenter = NotificationCenter.default
let kUserDefaults = UserDefaults.standard

/**< 获取当前系统时间戳 10位 */
func kGetCurentTime() -> String {
    return "\(Int(Date().timeIntervalSince1970))"
}

func kGetCurentTime_MS() -> String {
    return "\(Int(Date().timeIntervalSince1970 * 1000))"
}

func kVersion() -> String {
    let infoDictionary = Bundle.main.infoDictionary
    if let majorVersion = infoDictionary?["CFBundleShortVersionString"] {
        return "\(majorVersion)"
    }
    return ""
}

/**< 状态栏高度 */
func kStatusBarHeight() -> CGFloat {
    if #available(iOS 13, *) {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}

/**< iPhoneX */
func kJudgeIPhoneX() -> Bool {
    if #available(iOS 11, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0 > 0
    } else {
        return false
    }
}

/**< 底部安全距离 */
func kSafeBottom() -> CGFloat {
    if #available(iOS 11, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
    } else {
        return 0
    }
}

///  颜色
func kRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
    return kRGBA(red, green, blue, 1);
}

///  颜色
func kRGBA(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha);
}

/// 16进制颜色
func kColorFromRGB(_ color_vaule: UInt64) -> UIColor {
    let redValue = CGFloat((color_vaule & 0xFF0000) >> 16) / 255.0
    let greenValue = CGFloat((color_vaule & 0xFF00) >> 8) / 255.0
    let blueValue = CGFloat(color_vaule & 0xFF) / 255.0
    return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
}

/// 随机颜色
func kRandomColor() -> UIColor {
    let redValue = CGFloat(arc4random()) / CGFloat(RAND_MAX)
    let greenValue = CGFloat(arc4random()) / CGFloat(RAND_MAX)
    let blueValue = CGFloat(arc4random()) / CGFloat(RAND_MAX)
    return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
}

func kFastImage(_ image: String) -> UIImage {
    return UIImage(named: image) ?? UIImage()
}

func kHideKeyboard() {
    (UIApplication.shared.delegate?.window)??.endEditing(true)
}

/** 闭包 */
typealias kVoidClosureDefine = () -> Void
typealias kBoolClosureDefine = () -> Bool
typealias kIntClosureDefine = () -> Int
typealias kAnyClosureDefine = () -> Any

typealias kVoidClosureDefineBool = (Bool) -> Void
typealias kBoolClosureDefineBool = (Bool) -> Bool
typealias kIntClosureDefineBool = (Bool) -> Int
typealias kAnyClosureDefineBool = (Bool) -> Any

typealias kVoidClosureDefineInt = (_ index: Int) -> Void
typealias kBoolClosureDefineInt = (_ index: Int) -> Bool
typealias kIntClosureDefineInt = (_ index: Int) -> Int
typealias kAnyClosureDefineInt = (_ index: Int) -> Any

typealias kVoidClosureDefineString = (_ aString: String) -> Void
typealias kBoolClosureDefineString = (_ aString: String) -> Bool
typealias kIntClosureDefineString = (_ aString: String) -> Int
typealias kAnyClosureDefineString = (_ aString: String) -> Any

typealias kVoidClosureDefineID = (_ obj: Any) -> Void
typealias kBoolClosureDefineID = (_ obj: Any) -> Bool
typealias kIntClosureDefineSID = (_ obj: Any) -> Int
typealias kAnyClosureDefineSID = (_ obj: Any) -> Any

/** GCD */
func wk_dispatch_async_on_main_queue(callback: @escaping () -> Void) {
    DispatchQueue.main.async(execute: callback)
}

/** 异步 */
func wk_dispatch_async_on_global_queue(callback: @escaping () -> Void) {
    DispatchQueue.global().async(execute: callback)
}

/** 主线程 */
func wk_dispatch_after_main_queue(delay: Double, callback: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: callback)
}

/** 接收通知 */
var keyboardShow: String = UIResponder.keyboardWillShowNotification.rawValue
var keyboardHide: String = UIResponder.keyboardWillHideNotification.rawValue
func wk_addNotificationObserver(observer: Any, sel: Selector, name: String) {
    NotificationCenter.default.addObserver(
        observer,
        selector: sel,
        name: NSNotification.Name(rawValue: name),
        object: nil
    )
}

/** 区间 */
func kMin_Max(aMin: CGFloat, Pa: CGFloat, aMax: CGFloat) -> CGFloat {
    return max(aMin, min(Pa, aMax))
}

/** kSafari打开 */
func kSafariOpen(string: String) {
    guard let url = URL(string: string) else { return }
    if #available(iOS 10, *) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
        UIApplication.shared.openURL(url)
    }
}

/// 调到设置界面
func kOpenSetting() {
    kSafariOpen(string: UIApplication.openSettingsURLString)
}

/// 复制
func kCopyString(_ astring: String) {
    UIPasteboard.general.string = astring
}

///  打印
func kLogPrint<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
    
    // 1.获取文件名,包含后缀名
    let name = (file as NSString).lastPathComponent
    
    // 1.1 切割文件名和后缀名
    let fileArray = name.components(separatedBy: ".")
    
    // 1.2 获取文件名
    let fileName = fileArray[0]
    
    // 2.打印内容
    print("\(fileName) \(funcName) \(lineNum)行 ------>:\(message)")
    
    #endif
}

