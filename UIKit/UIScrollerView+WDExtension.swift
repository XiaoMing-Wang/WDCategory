//
//  WXMScrollerViewExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/25.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

extension UIScrollView {

    /**< contentOffsetX */
    var contentOffsetX: CGFloat {
        get { return contentOffset.x }
        set { contentOffset = CGPoint(x: newValue, y: contentOffsetY) }
    }
    
    /**< contentOffsetY */
    var contentOffsetY: CGFloat {
        get { return contentOffset.y }
        set { contentOffset = CGPoint(x: contentOffsetX, y: newValue) }
    }

    /**< contentSizeWidth */
    var contentSizeWidth: CGFloat {
        get { return contentSize.width }
        set { contentSize = CGSize(width: newValue, height: contentSizeHeight) }
    }

    /**< contentSizeHeight */
    var contentSizeHeight: CGFloat {
        get { return contentSize.height }
        set { contentSize = CGSize(width: contentSizeWidth, height: newValue) }
    }

    /**< contentInsetTop */
    var contentInsetTop: CGFloat {
        get { return contentInset.top  }
        set {
            contentInset = UIEdgeInsets(
                top: newValue,
                left: contentInsetLeft,
                bottom: contentInsetBottom,
                right: contentInsetRight
            )
        }
    }


    /**< contentInsetLeft */
    var contentInsetLeft: CGFloat {
        get { return contentInset.left }
        set {
            contentInset = UIEdgeInsets(
                top: contentInsetTop,
                left: newValue,
                bottom: contentInsetBottom,
                right: contentInsetRight
            )
        }
    }


    /**< contentInsetBottom */
    var contentInsetBottom: CGFloat {
        get { return contentInset.bottom }
        set {
            contentInset = UIEdgeInsets(
                top: contentInsetTop,
                left: contentInsetLeft,
                bottom: newValue,
                right: contentInsetRight
            )
        }
    }


    /**< contentInsetRight */
    var contentInsetRight: CGFloat {
        get { return contentInset.right }

        set {
            contentInset = UIEdgeInsets(
                top: contentInsetTop,
                left: contentInsetLeft,
                bottom: contentInsetBottom,
                right: newValue
            )
        }
    }

    /**< 滚动到顶部 */
    func srollsToTop_k(animated: Bool = true) {
        setContentOffset(.zero, animated: animated)
    }

    /**< 滚动到尾部 */
    func srollsToBottom_k(animated: Bool = true) {
        if self.contentSize.height > self.frame.size.height {
            let offsetY = self.contentSize.height - self.frame.size.height + self.contentInset.bottom
            setContentOffset(CGPoint(x: 0, y: offsetY), animated: animated)
        }
    }

    /**< 滚动优先级低于返回 */
    func rollingPriorityLow_k(controller: UIViewController) {
        if isScrollEnabled == false { return }
        let gesture: UIGestureRecognizer? = controller.navigationController?.interactivePopGestureRecognizer
        let panGesture: UIGestureRecognizer? = self.panGestureRecognizer
        if gesture == nil || panGesture == nil { return }
        panGesture!.require(toFail: gesture!)
    }

    /**< 滚动优先级低于返回 */
    func rollingPriorityHight_k(controller: UIViewController) {
        if isScrollEnabled == false { return }
        let gesture: UIGestureRecognizer? = controller.navigationController?.interactivePopGestureRecognizer
        let panGesture: UIGestureRecognizer? = self.panGestureRecognizer
        if gesture == nil || panGesture == nil { return }
        gesture!.require(toFail: panGesture!)
    }
    
    /**< 顶部留白  */
    func insertTopClearance(color: UIColor = .white) {
        let toplearance = UIView()
        toplearance.backgroundColor = color
        var frame = UIScreen.main.bounds
        frame.origin.y = -UIScreen.main.bounds.size.height
        toplearance.frame = frame
        insertSubview(toplearance, at: 0)
    }
    
    /**< 是否在最底部 */
    func isCurrentBottom(_ errorRatio: CGFloat = 0) -> Bool {
        let height = self.size.height
        let contentOffsetY = self.contentOffset.y
        let bottomOffset = self.contentSize.height - contentOffsetY
        if bottomOffset <= height + errorRatio {
            return true
        } else {
            return false
        }
    }

}
