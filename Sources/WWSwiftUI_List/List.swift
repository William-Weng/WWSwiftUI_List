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
    
    class List<Cell: WWSwiftUI.CellRepresentable>: WWSwiftUI.`Protocol` {
        
        public let hostingController: UIHostingController<AnyView>
        
        public var view: UIView { hostingController.view }
        
        private let dataSource: ListDataSource<Cell.Item>
        private let cellProvider: () -> Cell
        
        /// 初始化
        /// - Parameters:
        ///   - items: [Cell.Item]
        ///   - cellProvider: () -> Cell
        public init(items: [Cell.Item], cellProvider: @escaping () -> Cell) {
            
            self.cellProvider = cellProvider
            self.dataSource = ListDataSource(items: items)
            
            let rootView = ListView(dataSource: dataSource, cellProvider: cellProvider)
            hostingController = .init(rootView: AnyView(rootView))
        }
        
        deinit {
            removeHostingController()
        }
    }
}

// MARK: - 公開函式
public extension WWSwiftUI.List {
    
    /// 更新項目數值
    /// - Parameter newItems: [Cell.Item]
    func reloadData(_ newItems: [Cell.Item]) {
        dataSource.updateItems(newItems)
    }
}
