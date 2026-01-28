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
    
    class ListDataSource<Item: ItemIdentifiable>: ObservableObject {
        
        @Published var items: [Item]
        
        init(items: [Item]) {
            self.items = items
        }
    }
}

// MARK: - ListDataSource
extension WWSwiftUI.ListDataSource {
    
    /// 更新項目內容
    /// - Parameter newItems: [Item]
    func updateItems(_ newItems: [Item]) {
        items = newItems
    }
}
