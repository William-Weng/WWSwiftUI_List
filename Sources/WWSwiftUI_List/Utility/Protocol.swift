//
//  Protocol.swift
//  WWSwiftUI_List
//
//  Created by William.Weng on 2026/1/27.
//

import Foundation
import SwiftUICore
import WWSwiftUI_MultiDatePicker

// MARK: - Protocol
public extension WWSwiftUI {
    
    /// 為了讓Item有唯一值
    protocol ItemIdentifiable: Identifiable {
        var id: UUID { get }
    }
    
    /// 為了動態產生View的protocol
    protocol CellRepresentable {
        
        associatedtype Item: ItemIdentifiable
        
        func cell(for item: Item) -> any View
    }
}

// MARK: - Delegate
public extension WWSwiftUI {
    
    protocol ListDelegate: AnyObject {
        
        /// 項目點選功能
        func list<Cell>(_ list: WWSwiftUI.List<Cell>, didSelectedAt index: Int, item: Cell.Item)
        
        /// 側邊滑動選單功能
        func list<Cell>(_ list: WWSwiftUI.List<Cell>, swipeAction type: Int, edge: HorizontalEdge, didSelectedAt index: Int, item: Cell.Item)
    }
}
