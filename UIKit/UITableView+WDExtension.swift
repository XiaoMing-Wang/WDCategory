//
//  WXMUITableViewExtension.swift
//  IM_Client_Swift
//
//  Created by wq on 2020/5/27.
//  Copyright © 2020 wq. All rights reserved.
//
import UIKit
import Foundation

///
extension UITableView {
    
    //MARK: 滚动
    /// 滚动到顶部
    func scrollToFirstIndexPath_k(animated: Bool = true) {
        if (sectionCount() > 1 && rowCountOfSetion(0) > 1) {
            scrollToRow_k(row: 0, section: 0, position: .top, animated: animated)
        }
    }

    /// 滚动最后一个cell
    func scrollToLastIndexPath_k(animated: Bool = true) {
        let section = max(sectionCount() - 1, 0)
        let row = max(rowCountOfSetion(section) - 1, 0);
        scrollToRow_k(row: row, section: section, position: .bottom, animated: animated)
    }

    /// 滚动到某个cell
    func scrollToRow_k(row: Int, section: Int = 0, position: UITableView.ScrollPosition, animated: Bool = true) {
        if (sectionCount() > section && rowCountOfSetion(section) > row) {
            let indexPath: IndexPath = IndexPath(row: row, section: section)
            scrollToRow(at: indexPath, at: position, animated: animated)
        }
    }

    /// 滚动到某个cell IndexPath
    func scrollToIndexPath_k(indexPath: IndexPath, position: UITableView.ScrollPosition, animated: Bool) {
        scrollToRow_k(row: indexPath.row, section: indexPath.section, position: position, animated: animated)
    }

    //MARK: 刷新
    /// 刷新某个cell row
    func reloadRow_k(row: Int, section: Int, animated: UITableView.RowAnimation) {
        if (sectionCount() > section && rowCountOfSetion(section) > row) {
            let indexPath: IndexPath = IndexPath(row: row, section: section)
            reloadRows(at: [indexPath], with: animated)
        }
    }

    /// 刷新某个IndexPath
    func reloadToIndexPath_k(indexPath: IndexPath, animated: UITableView.RowAnimation) {
        reloadRow_k(row: indexPath.row, section: indexPath.section, animated: animated)
    }

    /// 刷新某列
    func reloadSection_k(section: Int, animated: UITableView.RowAnimation) {
        if self.sectionCount() > section {
            let indexSet: IndexSet = IndexSet(integer: section)
            reloadSections(indexSet, with: animated)
        }
    }
    
    //MARK: 插入
    ///插入cell row
    func insertRow_k(row: Int, section: Int, animated: UITableView.RowAnimation) {
        if self.sectionCount() >= section && rowCountOfSetion(section) >= row {
            let indexPath: IndexPath = IndexPath(row: row, section: section)
            insertRows(at: [indexPath], with: animated)
        }
    }

    ///插入cell IndexPath
    func insertToAtIndexPath_k(indexPath: IndexPath, animated: UITableView.RowAnimation) {
        insertRow_k(row: indexPath.row, section: indexPath.section, animated: animated)
    }

    //MARK: 删除
    ///删除cell row
    func deleteRow_k(row: Int, section: Int, animated: UITableView.RowAnimation) {
        if self.sectionCount() > section && rowCountOfSetion(section) > row {
            let indexPath: IndexPath = IndexPath(row: row, section: section)
            deleteRows(at: [indexPath], with: animated)
        }
    }

    ///删除cell IndexPath
    func delleteToIndexPath_k(indexPath: IndexPath, animated: UITableView.RowAnimation) {
        deleteRow_k(row: indexPath.row, section: indexPath.section, animated: animated)
    }

    ///删除cell Section
    func deleteSection_k(section: Int, animated: UITableView.RowAnimation) {
        if self.sectionCount() > section {
            let indexSet: IndexSet = IndexSet(integer: section)
            deleteSections(indexSet, with: animated)
        }
    }

    //MARK: 获取
    ///获取有几个组
    func sectionCount() -> Int {
        max(self.numberOfSections, 0)
    }
    
    ///获取某组有多少行
    func rowCountOfSetion(_ section: Int) -> Int {
        max(self.numberOfRows(inSection: section), 0)
    }

    /** 是否是最后一个cell */
    func isLastCell(_ index: IndexPath) -> Bool {
        let rowCount = rowCountOfSetion(index.section)
        return (rowCount == index.row + 1)
    }
    
}

