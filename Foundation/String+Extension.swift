////
////  String+Extension.swift
////  im-client
////
////  Created by 欧阳洪彬 on 2020/6/6.
////  Copyright © 2020 IM. All rights reserved.
////
//
//import Foundation
//import CommonCrypto
//
//extension String {
//    
//    func fx_size(withFont font: UIFont) -> CGSize {
//        
//        return (self as NSString).size(withAttributes: [.font :font])
//    }
//    
//    func fx_dateString() -> String {
//        
//        let dateRegion = self.toDate()
//        if dateRegion != nil {
//            
//            if dateRegion!.date.isInToday {
//                
//                let nowDate = Date()
//                let components = NSCalendar.current.dateComponents([ .hour, .minute], from: dateRegion!.date, to: nowDate)
//                if components.hour ?? 0 > 0 {
//                    
//                    return "\(components.hour ?? 0)小时前"
//                } else if components.minute ?? 0 > 0 {
//                    
//                    return "\(components.minute ?? 0)分钟前"
//                } else {
//                    
//                    return "1分钟前"
//                }
//            } else if dateRegion!.date.isYesterday {
//                
//                return "昨天"
//            } else {
//                
//                return dateRegion!.date.string(withFormat: "yyyy-MM-dd")
//            }
//        }
//        return ""
//    }
//    
//    func fx_substring(location index:Int, length:Int) -> String {
//        
//        if self.count > index {
//            
//            let startIndex = self.index(self.startIndex, offsetBy: index)
//            let endIndex = self.index(self.startIndex, offsetBy: index + length)
//            let subString = self[startIndex..<endIndex]
//            return String(subString)
//        } else {
//            
//            return self
//        }
//    }
//    
//    func fx_substring(range:NSRange) -> String {
//        
//        if self.count > range.location {
//            
//            let startIndex = self.index(self.startIndex, offsetBy: range.location)
//            let endIndex = self.index(self.startIndex, offsetBy: range.location + range.length)
//            let subString = self[startIndex..<endIndex]
//            return String(subString)
//        } else {
//            
//            return self
//        }
//    }
//    
//    func fx_md5() -> String {
//        
//        let utf8 = cString(using: .utf8)
//        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
//        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
//        return digest.reduce("") { $0 + String(format:"%02x", $1) }
//    }
//    
//    func fx_urlScheme(scheme: String) -> URL? {
//
//        if let url = URL.init(string: self) {
//
//            var components = URLComponents.init(url: url, resolvingAgainstBaseURL: false)
//            components?.scheme = scheme
//            return components?.url
//        }
//        return nil
//    }
//    
//    static func fx_readJson2DicWithFileName(fileName:String) -> [String:Any] {
//
//        let path = Bundle.main.path(forResource: fileName, ofType: "json") ?? ""
//        var dict = [String: Any]()
//        do {
//            let data = try Data.init(contentsOf: URL.init(fileURLWithPath: path))
//            dict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//        } catch {
//            print(error.localizedDescription)
//        }
//        return dict
//    }
//    
//    static func fx_format(decimal:Float, _ maximumDigits:Int = 1, _ minimumDigits:Int = 1) ->String? {
//        
//        let number = NSNumber(value: decimal)
//        let numberFormatter = NumberFormatter()
//        numberFormatter.maximumFractionDigits = maximumDigits //设置小数点后最多2位
//        numberFormatter.minimumFractionDigits = minimumDigits //设置小数点后最少2位（不足补0）
//        return numberFormatter.string(from: number)
//    }
//    
//    static func fx_formatCount(count:NSInteger) -> String {
//        
//        if count < 10000  {
//            
//            return String.init(count)
//        } else {
//            
//            return (String.fx_format(decimal: Float(count)/Float(10000)) ?? "0") + "w"
//        }
//    }
//    
//    func fx_singleLineSizeWithText(font:UIFont) -> CGSize {
//        
//        return self.size(withAttributes: [NSAttributedString.Key.font : font])
//    }
//    
//    func fx_singleLineSizeWithAttributeText(font:UIFont) -> CGSize {
//        
//        let attributes = [NSAttributedString.Key.font:font]
//        let attString = NSAttributedString(string: self,attributes: attributes)
//        let framesetter = CTFramesetterCreateWithAttributedString(attString)
//        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude), nil)
//    }
//}
