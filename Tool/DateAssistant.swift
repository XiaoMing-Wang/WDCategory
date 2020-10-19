//
//  DateAssistant.swift
//  im-client
//
//  Created by imMac on 2020/9/12.
//  Copyright © 2020 IM. All rights reserved.
//

import UIKit

class DateAssistant: NSObject {
    
    /** 获取当前系统时间戳 10位 */
    class func DateGetCurentTime() -> String {
        return "\(Int(Date().timeIntervalSince1970))"
    }

    /** 获取当前系统时间戳 10位 */
    class func DateGetCurentTime() -> Int64 {
        return Int64(Date().timeIntervalSince1970)
    }

    /** 获取当前系统时间戳 13位 */
    class func DateGetCurentTime_MS() -> String {
        return "\(Int(Date().timeIntervalSince1970 * 1000))"
    }

    /** 获取当前系统时间戳 13位 */
    class func DateGetCurentTime_MS() -> Int64 {
        return (Int64(Date().timeIntervalSince1970 * 1000))
    }

    /** 获取10位的时间 */
    class func DateGetSeconds(timeStamp: Int64) -> Int64 {
        let timeSting = "\(timeStamp)"
        if timeSting.count >= 13 {
            return Int64(timeSting.subStringIndex_k(0, 10).intValue)
        } else if timeSting.count < 10 {
            return 0
        } else {
            return Int64(timeSting.intValue)
        }
    }
    
    /** 获取10位的时间 */
    class func DateGetSecondsString(timeStamp: String) -> String {
        if timeStamp.count >= 13 {
            return timeStamp.subStringIndex_k(0, 10)
        } else if timeStamp.count < 10 {
            return ""
        } else {
            return timeStamp
        }
    }
    
    /** 判断是否是上午 */
    class func am_pm(_ timeStamp: String) -> String {
        let formatter = "HH"
        let time = timeStamp.timeWithFormatter_k(formatter: formatter).intValue
        return (time <= 12) ? "上午" : "下午"
    }
    
    /** 判断是否是今年 */
    class func isThisYear(_ timeStamp: String) -> Bool {
        let formatter = "yyyy"
        let timeString = timeStamp.timeWithFormatter_k(formatter: formatter)
        let curentTime = DateGetCurentTime().timeWithFormatter_k(formatter: formatter)
        return (timeString == curentTime)
    }

    /** 判断是否是今天 */
    class func isToDay(_ timeStamp: String) -> Bool {
        let formatter = "yyyy-MM-dd"
        let timeString = timeStamp.timeWithFormatter_k(formatter: formatter)
        let curentTime = DateGetCurentTime().timeWithFormatter_k(formatter: formatter)
        return (timeString == curentTime)
    }

    /** 判断是否是昨天 */
    class func isYesterday(_ timeStamp: String) -> Bool {
        let targetTime = (timeStamp.count > 10) ? timeStamp.subStringIndex_k(0, 10): timeStamp
        let targetInt64 = UInt64(targetTime) ?? 0
        
        /** 今天0点的时间戳 */
        let todayZero = DateGetCurentTime().timeWithFormatter_k(formatter: "yyyy-MM-dd").timestampForYYYY_MM_DD_k()
        let todayZeroInt64 = UInt64(todayZero)
        if targetInt64 >= todayZeroInt64 || targetInt64 == 0 {
            return false
        }
        return (todayZeroInt64 - targetInt64) < 24 * 60 * 60
    }

    /** 判断时间间隔返回 秒 */
    class func judgeTimeInterval(_ timeStamp: Int64?) -> Int64 {
        guard let timeStamp = timeStamp else { return 0 }
        let targetTime: Int64 = DateGetSeconds(timeStamp: timeStamp)
        let current: Int64 = DateGetCurentTime()
        return (targetTime - current)
    }

    /** 判断时间间隔返回 秒 */
    class func judgeTimeInterval(_ timeStamp: String?) -> Int64 {
        guard let timeStamp = timeStamp else { return 0 }
        return judgeTimeInterval(Int64(timeStamp))
    }
    
    /** 判断是不是几天后 */
    class func judgeTimeInterval(_ timeStamp: Int64?, day: Int) -> Bool {
        guard let timeStamp = timeStamp else { return false }
        let interval = judgeTimeInterval(timeStamp)
        if interval < 0 {
            return false
        }
        return interval > (60 * 60 * 24 * day)
    }

}
