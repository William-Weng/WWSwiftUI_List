//
//  CellViewUI.swift
//  Example
//
//  Created by William.Weng on 2026/1/28.
//

import Foundation
import SwiftUI
import WWSwiftUI_MultiDatePicker

// MARK: - ViewModel
struct CellItem: WWSwiftUI.ItemIdentifiable {

    let id = UUID()
    let title: String
    let detail: String
}

// MARK: - UIView => View
struct CellViewUI: WWSwiftUI.CellRepresentable {
    
    typealias Item = CellItem
    typealias UIViewType = CellView
    
    let item: Item
    let useFitSize: Bool
        
    private init(item: Item, useFitSize: Bool) {
        self.item = item
        self.useFitSize = useFitSize
    }
    
    init() {
        item = .init(title: "", detail: "")
        useFitSize = true
    }
    
    /// Cell產生器
    /// - Parameter item: Item
    /// - Returns: any View
    func cell(for item: Item) -> any View {
        CellViewUI(item: item, useFitSize: useFitSize)
    }
}

// MARK: - UIViewRepresentable
extension CellViewUI: UIViewRepresentable {
    
    /// 產生UIView給SwiftUI使用
    /// - Parameter context: Context
    /// - Returns: <UIViewType>
    func makeUIView(context: Context) -> UIViewType {
        return UIViewType()
    }
    
    /// 在SwfitUI中更新UIView
    /// - Parameters:
    ///   - uiView: <UIViewType>
    ///   - context: Context
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.configure(item: item)
    }
    
    /// 計算適合的尺寸 (動態大小)
    /// - Parameters:
    ///   - proposal: ProposedViewSize
    ///   - uiView: <UIViewType>
    ///   - context: Context
    /// - Returns: CGSize?
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize? {
        let fitSize = proposal.fitHeight(uiView: uiView)
        return useFitSize ? fitSize : nil
    }
}
