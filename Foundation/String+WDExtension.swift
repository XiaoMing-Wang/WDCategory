//
//  StringExtension.swift
//  SwiftDemo2
//
//  Created by wq on 2020/4/27.
//  Copyright © 2020 wxm. All rights reserved.
//
import UIKit
import Foundation
import CoreText
import CommonCrypto

extension String {
    
    /**< 判断是否可用 */
    var available: Bool {
        get {
            let tempString = self
            return tempString != "" && tempString.count > 0
        }
    }

    var availableValue: String? {
        get {
            let tempString: String? = (count > 0) ? self : nil
            return tempString
        }
    }

    /**< 去掉空格 */
    var removeSpace: String {
        get {
            return self.replacingOccurrences(of: " ", with: "")
        }
    }
    
    /**< 转换成url */
    var urlConvert: URL? {
        get {
            return URL(string: self) ?? nil
        }
    }
        
    /**< 字符串转字典 */
    var jsonToDictionary: Dictionary<String, Any> {
        get {
            let aString = self
            let jsonData = aString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            if jsonData == nil { return [:] }
            let obj = try? JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers)
            return obj as? Dictionary<String, Any> ?? [:]
        }
    }
                        
    /**< floatValue */
    var floatValue: Float {
        get {
            let string = self
            var cgFloat: Float = 0
            if let doubleValue = Double(string) {
                cgFloat = Float(doubleValue)
            }
            return cgFloat
        }
    }
    
    /**< intValue */
    var intValue: Int {
        get {
            let string = self
            return Int(string) ?? 0
        }
    }

    /**< intValue */
    var int64Value: Int64 {
        get {
            let string = self
            return Int64(string) ?? 0
        }
    }
    
    /**< doubleValue */
    var doubleValue: Double {
        get {
            let string = self
            return Double(string) ?? 0.0
        }
    }
    
    /**< 保留小数 */
    func preciseTdigits_k(digits: Int) -> String {
        let currentDigits = self.components(separatedBy: ".").last?.count
        if digits == currentDigits { return self }
        let format = String(format: "%%.%ldf", digits)
        return String(format: format, self.doubleValue)
    }

    /**< 截取字符串  */
    func subStringIndex_k(_ start: Int, _ count: Int) -> String {
        let aString: String = self
        let idxStart = aString.index(aString.startIndex, offsetBy: start)
        let idxEnd = aString.index(aString.startIndex, offsetBy: min(start + count, self.count))
        let newString = aString[idxStart..<idxEnd]
        return String(newString)
    }
    
    //MARK: 获取宽高
    /**< 获取字符串的height */
    func getWidthFont_k(fontSize: CGFloat) -> CGFloat {
        getSizeFont_k(fontSize: fontSize, width: CGFloat(MAXFLOAT)).width
    }

    /**< 获取字符串的height  */
    func getHeightFont_k(fontSize: CGFloat) -> CGFloat {
        getSizeFont_k(fontSize: fontSize, width: CGFloat(MAXFLOAT)).height
    }
    
    /**< 获取字符串的height */
    func getHeightFont_k(fontSize: CGFloat, width: CGFloat = CGFloat(MAXFLOAT)) -> CGFloat {
        getSizeFont_k(fontSize: fontSize, width: width).height
    }

    /**< 获取字符串的size */
    func getSizeFont_k(fontSize: CGFloat, width: CGFloat) -> CGSize {
        let fSize = (fontSize == 0) ? fontSize : UIFont.systemFontSize
        let expectedSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let font = UIFont.systemFont(ofSize: fSize)
        let string = NSString(string: self)
        let expectedRect = string.boundingRect(
            with: expectedSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return expectedRect.size
    }
    
    //MARK: 转换时间戳
    /**< 时间戳转换成yyyy-MM-dd */
    func timeForYYYY_MM_DD_k() -> String {
        timeWithFormatter_k(formatter: "yyyy-MM-dd")
    }

    func timeForYYYY_MM_DD_HH_MM_k() -> String {
        timeWithFormatter_k(formatter: "yyyy-MM-dd HH:mm")
    }

    /**< 时间戳转换成年月日 */
    func timeWithFormatter_k(formatter: String) -> String {
        let time = (count > 10) ? subStringIndex_k(0, 10): self
        let detaildate = NSDate(timeIntervalSince1970: time.doubleValue)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 8)
        return dateFormatter.string(from: detaildate as Date)
    }

    /**< 年月日格式转换时间戳 */
    func timestampWithFormatter_k(formatter: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        let fromDate = dateFormatter.date(from: self)
        return Int(fromDate?.timeIntervalSince1970 ?? 0)
    }

    /**< 年月日格式转换时间戳 */
    func timestampForYYYY_MM_DD_k() -> Int {
        timestampWithFormatter_k(formatter: "yyyy-MM-dd")
    }
    
    /**< 拼音  */
    func changePinyin_k() -> String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        return mutableString.folding(options: .diacriticInsensitive, locale: NSLocale.current).lowercased()
    }

    /**< 中文   */
    func chinese_k() -> Bool {
        guard self.count > 0 else { return false }
        let match: String = "(^[\\u4e00-\\u9fa5]+$)"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }
    
    /**< md5  */
    func fx_md5() -> String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02x", $1) }
    }
        
    /**< 截取字符串中的字符 */
    func regularMatch(starting: String, ending: String) -> String {
        let startRange = self.range(of: starting)
        let endRange = self.range(of: ending)
        if let startRange = startRange, let endRange = endRange, endRange.lowerBound > startRange.upperBound {
            let substr = self[startRange.upperBound..<endRange.lowerBound]
            return String(substr)
        }
        return ""
    }
}
