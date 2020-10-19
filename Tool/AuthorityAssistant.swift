//
//  AuthorityAssistant.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/25.
//  Copyright © 2020 wq. All rights reserved.
//

import UIKit
import Foundation
import Photos
import ContactsUI

class AuthorityAssistant: NSObject {

    /** 相册权限 */
    class func photoAuthority(call: @escaping (Bool) -> Void) {

        let photoStatus = PHPhotoLibrary.authorizationStatus()
        if photoStatus == .authorized {

            call(true)
        } else if photoStatus == .restricted || photoStatus == .denied {
            
            call(false)
            let msg = "请在系统设置中将“照片”权限修改为“读取和写入”，否则将无法读取照片"
            showAlertViewController("提示", msg: msg, canStr: "取消", otherAction: "开启") { (idx) in
                if idx { kOpenSetting() }
            }
            
        } else {
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async {
                    call(status == .authorized)
                }
            }
        }
    }


    /** 相机权限 */
    class func cameraAuthority(call: @escaping (Bool) -> Void) {

        let media: AVMediaType = .video
        let status: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: media)

        if status == .authorized {
            
            call(true)
        } else if status == .restricted || status == .denied {

            call(false)
            let msg = "请在系统设置中打开“相机”权限开关，否则将无法使用相机功能"
            showAlertViewController("提示", msg: msg, canStr: "取消", otherAction: "开启") { (idx) in
                if idx { kOpenSetting() }
            }
            
        } else {
            AVCaptureDevice.requestAccess(for: media) { (authorized) in
                DispatchQueue.main.async {
                    call(authorized)
                }
            }
        }
    }
    
    /** 麦克风权限 */
    class func audioAuthority(authorizedCall: Bool = true, call: @escaping (Bool) -> Void) {

        let media: AVMediaType = .audio
        let status: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: media)

        if status == .authorized {
            
            call(true)
        } else if status == .restricted || status == .denied {

            call(false)
            let msg = "请在系统设置中打开“麦克风”权限开关，否则将无法使用麦克风功能"
            showAlertViewController("提示", msg: msg, canStr: "取消", otherAction: "开启") { (idx) in
                if idx { kOpenSetting() }
            }
            
        } else {
            AVCaptureDevice.requestAccess(for: media) { (authorized) in
                DispatchQueue.main.async {
                    authorizedCall ? call(authorized) : ()
                }
            }
        }
    }
    
    /** 位置权限 */
    class func locationAuthority() -> Bool {

        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if ((status == .denied || status == .authorizedWhenInUse || status == .authorizedAlways) &&
            (CLLocationManager.locationServicesEnabled())) {
            return true;
        }
        
        let msg = "请在系统设置中打开“位置”修改成“始终”或“使用App期间”，否则无法获取到位置信息"
        showAlertViewController("提示", msg: msg, canStr: "取消", otherAction: "开启") { (idx) in
            if idx { kOpenSetting() }
        }
        
        return false
    }
    
    /** 通讯录权限 */
    class func contactAuthority(call: @escaping (Bool) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .authorized {

            call(true)
        } else if status == .restricted || status == .denied {

            call(false)
            let message = "请在系统设置中打开“通讯录”权限开关，否则将无法获取联系人资料"
            showAlertViewController("提示", msg: message, canStr: "取消", otherAction: "开启") { (idx) in
                idx ? kOpenSetting() : ()
            }
        } else {
            CNContactStore().requestAccess(for: .contacts) { (authorized, error) in
                DispatchQueue.main.async {
                    call(authorized)
                }
            }
        }
    }
    
    class fileprivate func showAlertViewController (
        _ title: String,
        msg: String,
        canStr: String,
        otherAction: String,
        call: ((Bool) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancle = UIAlertAction(title: canStr, style: .cancel) { (action) in
            call?(false)
        }

        let setting = UIAlertAction(title: otherAction, style: .default) { (action) in
            call?(true)
        }

        alert.addAction(cancle)
        alert.addAction(setting)
        
        var window: UIWindow? = nil
        if #available(iOS 13, *) {
            window = UIApplication.shared.windows[0]
        } else {
            window = UIApplication.shared.keyWindow
        }
        
        var rootVC = window?.rootViewController
        if rootVC?.presentingViewController != nil {
            rootVC = rootVC!.presentingViewController
        }
        rootVC?.present(alert, animated: true, completion: nil)
    }
    
    
    class fileprivate func kOpenSetting() {
        let url: URL? = URL(string: UIApplication.openSettingsURLString)
        if url == nil { return }

        if #available(iOS 10, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
    }
    
}
