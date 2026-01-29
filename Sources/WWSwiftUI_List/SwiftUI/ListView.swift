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
                        .onTapGesture {
                            itemSelectedAction(at: index, item: item)
                        }
                        ._if(!dataSource.leadingConfigures.isEmpty, transform: { cell in
                            cell.swipeActions(edge: .leading) {
                                swipeButtonsMaker(index: index, item: item, configs: dataSource.leadingConfigures, edge: .leading)
                            }
                        })
                        ._if(!dataSource.trailingConfigures.isEmpty, transform: { cell in
                            cell.swipeActions(edge: .trailing) {
                                swipeButtonsMaker(index: index, item: item, configs: dataSource.trailingConfigures, edge: .trailing)
                            }
                        })
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

// MARK: - 小工具
private extension WWSwiftUI.ListView {
    
    /// 側邊選單產生器
    /// - Parameters:
    ///   - index: 序號
    ///   - item: 項目
    ///   - configs: 設定
    ///   - edge: 方位
    /// - Returns: some View
    @ViewBuilder
    func swipeButtonsMaker(index: Int, item: Cell.Item, configs: [WWSwiftUI.SwipeButtonConfigure], edge: HorizontalEdge) -> some View {
        
        ForEach(configs, id: \.type) { config in
            Button(config.title) {
                if let parent = dataSource.parent { parent.delegate?.list(parent, swipeAction: config.type, edge: edge, didSelectedAt: index, item: item) }
            }.tint(config.tintColor)
        }
    }
    
    func itemSelectedAction(at index: Int, item: Cell.Item) {
        guard let parent = dataSource.parent else { return }
        parent.delegate?.list(parent, didSelectedAt: index, item: item)
    }
}
