//
//  Extension.swift
//  WWSwiftUI_List
//
//  Created by William.Weng on 2026/1/27.
//

import SwiftUI

// MARK: - ProposedViewSize
public extension ProposedViewSize {
    
    /// 尋找適合的高度 (動態高度)
    /// - Parameter uiView: UIViewType
    /// - Returns: CGSize
    func fitHeight<UIViewType: UIView>(uiView: UIViewType) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let targetWidth = (width ?? screenWidth)
        let targetHeight = UIView.layoutFittingCompressedSize.height
        let targetSize = CGSize(width: targetWidth, height: targetHeight)
        
        return uiView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}
