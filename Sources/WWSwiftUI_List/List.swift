//
//  List.swift
//  WWSwiftUI_List
//
//  Created by William.Weng on 2026/1/27.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker

// MARK: - List
public extension WWSwiftUI {
    
    class List<Cell>: WWSwiftUI.`Protocol` where Cell: CellRepresentable {
        
        public let hostingController: UIHostingController<AnyView>
        
        public var view: UIView { hostingController.view }
                
        public weak var delegate: (any WWSwiftUI.ListDelegate)?
        
        private let dataSource: ListDataSource<Cell>
        private let cellProvider: () -> Cell
        
        /// 初始化
        /// - Parameters:
        ///   - items: [Cell.Item]
        ///   - cellProvider: () -> Cell
        public init(items: [Cell.Item], cellProvider: @escaping () -> Cell) {
            
            self.cellProvider = cellProvider
            dataSource = ListDataSource(items: items)
            
            let rootView = ListView(dataSource: dataSource, cellProvider: cellProvider)
            hostingController = .init(rootView: AnyView(rootView))
            dataSource.parent = self
        }
                
        deinit {
            delegate = nil
            removeHostingController()
        }
    }
}

// MARK: - 公開函式
public extension WWSwiftUI.List {
    
    /// 更新項目數值
    /// - Parameters:
    ///   - newItems: 所有項目
    ///   - animation: 動畫設定
    func reloadData(_ newItems: [Cell.Item] = [], animation: Animation = .default) {
        withAnimation(animation) { dataSource.items = newItems }
    }
    
    /// 新增項目
    /// - Parameters:
    ///   - newItem: 項目
    ///   - animation: 動畫設定
    func appendItem(with newItem: Cell.Item, animation: Animation? = .easeInOut) {
        withAnimation(animation) { dataSource.items.append(newItem) }
    }
    
    /// 刪除項目
    /// - Parameters:
    ///   - index: 項目序號
    ///   - animation: 動畫設定
    func removeItem(at index: Int, animation: Animation? = .spring) {
        withAnimation(animation) { dataSource.items.remove(at: index) }
    }
    
    /// 編譯項目
    /// - Parameters:
    ///   - editItem: 更新項目
    ///   - index: 項目序號
    ///   - animation: 動畫設定
    func editItem(_ editItem: Cell.Item, at index: Int, animation: Animation? = .spring) {
        withAnimation(animation) { dataSource.items[index] = editItem }
    }
    
    /// [左側滑動選單設定](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/客製表格-table-的-swipe-action-bed0a8bf7979)
    /// - Parameter configures: [WWSwiftUI.SwipeButtonConfigure]
    func leadingConfigures(_ configures: [WWSwiftUI.SwipeButtonConfigure]) {
        dataSource.leadingConfigures = configures
    }
    
    /// [右側滑動選單設定](https://ithelp.ithome.com.tw/m/articles/10332531)
    /// - Parameter configures: [WWSwiftUI.SwipeButtonConfigure]
    func trailingConfigures(_ configures: [WWSwiftUI.SwipeButtonConfigure]) {
        dataSource.trailingConfigures = configures
    }
}
