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
        ///   - trailingConfigures: [SwipeButtonConfigure]
        ///   - delegate: ListViewDelegate?
        ///   - cellProvider: () -> Cell
        public init(items: [Cell.Item], trailingConfigures: [SwipeButtonConfigure], cellProvider: @escaping () -> Cell) {
            
            self.cellProvider = cellProvider
            self.dataSource = ListDataSource(items: items, trailingConfigures: trailingConfigures)
            
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
    /// - Parameter newItems: [Cell.Item]
    func reloadData(_ newItems: [Cell.Item]) {
        dataSource.updateItems(newItems)
    }
}
