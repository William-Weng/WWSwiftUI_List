//
//  File.swift
//  WWSwiftUI_List
//
//  Created by William.Weng on 2026/1/28.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker

// MARK: - ListDataSource
extension WWSwiftUI {
    
    class ListDataSource<Cell>: ObservableObject where Cell: CellRepresentable {
        
        @Published var parent: List<Cell>?
        @Published var items: [Cell.Item]
        @Published var leadingConfigures: [SwipeButtonConfigure]
        @Published var trailingConfigures: [SwipeButtonConfigure]
        
        /// 初始化
        /// - Parameters:
        ///   - items: 內容項目
        init(items: [Cell.Item]) {
            self.parent = nil
            self.items = items
            self.leadingConfigures = []
            self.trailingConfigures = []
        }
    }
}
