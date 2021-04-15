//
//  WQTextFieldExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/24.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

protocol WXMKitTextFieldDelegate: NSObjectProtocol {
    func wc_textFieldDidBeginEditing(_ textField: UITextField)
    func wc_textFieldValueChanged(_ textField: UITextField)
    func wc_textFieldShouldClear(_ textField: UITextField) -> Bool
    func wc_textFieldShouldReturn(_ textField: UITextField) -> Bool
    func wc_textFieldShouldEdit(_ textField: UITextField, replace aString: String) -> Bool
}

extension WXMKitTextFieldDelegate {
    func wc_textFieldDidBeginEditing(_ textField: UITextField) { }
    func wc_textFieldValueChanged(_ textField: UITextField) { }
    func wc_textFieldShouldClear(_ textField: UITextField) -> Bool { return true }
    func wc_textFieldShouldReturn(_ textField: UITextField) -> Bool { return true }
    func wc_textFieldShouldEdit(_ textField: UITextField, replace aString: String) -> Bool { return true }
}

extension UITextField: UITextFieldDelegate {
     
    private struct AssociateKeys {
        static var maxChter: Void?
        static var delegateKit: Void?
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegateKit?.wc_textFieldDidBeginEditing(textField)
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.delegateKit?.wc_textFieldShouldClear(textField) ?? true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.delegateKit?.wc_textFieldShouldReturn(textField) ?? true
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string.count == 0 || string == "") { return true }
        return self.delegateKit?.wc_textFieldShouldEdit(textField, replace: string) ?? true
    }
    
    //MARK: maxCharacter
    var maxCharacter: NSInteger {

        get {
            let maxString = objc_getAssociatedObject(self, &AssociateKeys.maxChter) as? String
            guard maxString != nil else {
                return 0
            }
            return Int(maxString ?? "0") ?? 0
        }

        set {
            let maxString = String(newValue)
            objc_setAssociatedObject(self, &AssociateKeys.maxChter, maxString, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.addTarget(self, action: #selector(__textFieldValueChanged(_:)), for: .allEditingEvents)
        }
    }

    //MARK: delegateKit
    var delegateKit: WXMKitTextFieldDelegate? {
        get {
            let delegateKit = objc_getAssociatedObject(self, &AssociateKeys.delegateKit)
            return delegateKit as? WXMKitTextFieldDelegate ?? nil
        }
        
        set {
            self.delegate = self
            self.addTarget(self, action: #selector(__textFieldValueChanged(_:)), for: .allEditingEvents)
            objc_setAssociatedObject(self, &AssociateKeys.delegateKit, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }

    }

    @objc fileprivate func __textFieldValueChanged(_ textField: UITextField) {
        willChangeValue(forKey: "text")
        didChangeValue(forKey: "text")

        delegateKit?.wc_textFieldValueChanged(textField)
        if self.maxCharacter > 0 && textField.text?.count ?? 0 > self.maxCharacter {
            let text = textField.text ?? ""
            textField.text = String(text.prefix(self.maxCharacter))
        }
    }

}
