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
    
    class ListDataSource<Cell: CellRepresentable>: ObservableObject {
        
        @Published var parent: List<Cell>?
        @Published var items: [Cell.Item]
        @Published var trailingConfigures: [SwipeButtonConfigure]
        
        init(items: [Cell.Item], trailingConfigures: [SwipeButtonConfigure]) {
            self.items = items
            self.trailingConfigures = trailingConfigures
        }
    }
}

// MARK: - ListDataSource
extension WWSwiftUI.ListDataSource {
    
    /// 更新項目內容
    /// - Parameter newItems: [Item]
    func updateItems(_ newItems: [Cell.Item]) {
        items = newItems
    }
}
