//
//  ListView.swift
//  WWSwiftUI_List
//
//  Created by William.Weng on 2026/1/27.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker

// MARK: - ListView (SwiftUI)
public extension WWSwiftUI {
    
    struct ListView<Cell>: View where Cell: WWSwiftUI.CellRepresentable {
        
        @ObservedObject var dataSource: ListDataSource<Cell>
        
        private let cellProvider: () -> Cell
        
        init(dataSource: ListDataSource<Cell>, @ViewBuilder cellProvider: @escaping () -> Cell) {
            self.dataSource = dataSource
            self.cellProvider = cellProvider
        }
        
        public var body: some View {
            
            SwiftUI.List {
                
                ForEach(Array(zip(dataSource.items.indices, dataSource.items)), id: \.1.id) { index, item in
                    
                    AnyView(cellProvider().cell(for: item))
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        ._if(!dataSource.trailingConfigures.isEmpty, transform: { cell in
                            cell.swipeActions(edge: .trailing) {
                                swipeButtonsMaker(index: index, item: item, configs: dataSource.trailingConfigures)
                            }
                        })
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

private extension WWSwiftUI.ListView {
    
    @ViewBuilder
    func swipeButtonsMaker(index: Int, item: Cell.Item, configs: [WWSwiftUI.SwipeButtonConfigure]) -> some View {
        
        ForEach(configs, id: \.type) { config in
            
            Button(config.title) {
                if let parent = dataSource.parent {
                    parent.delegate?.list(parent, trailingSwipe: config.type, didSelectedAt: index, item: item)
                }
            }.tint(config.tintColor)
        }
    }
}
