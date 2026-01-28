//
//  ListView.swift
//  WWSwiftUI_List
//
//  Created by William.Weng on 2026/1/27.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker

// MARK: - ListView (SwiftUI)
extension WWSwiftUI {
    
    struct ListView<Cell: WWSwiftUI.CellRepresentable>: View where Cell.Item: WWSwiftUI.ItemIdentifiable {
        
        @ObservedObject var dataSource: ListDataSource<Cell.Item>
        
        private let cellProvider: () -> Cell
        
        init(dataSource: ListDataSource<Cell.Item>, @ViewBuilder cellProvider: @escaping () -> Cell) {
            self.dataSource = dataSource
            self.cellProvider = cellProvider
        }
        
        public var body: some View {
            
            SwiftUI.List(dataSource.items, id: \.id) { item in
                AnyView(cellProvider().cell(for: item))
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}
