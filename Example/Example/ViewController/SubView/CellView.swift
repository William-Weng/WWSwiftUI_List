//
//  CellView.swift
//  Example
//
//  Created by Willia on 2026/1/28.
//

import UIKit
import SwiftUI
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_List

// MARK: - 自訂View
final class CellView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromXib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromXib()
    }
    
    func configure(item: CellItem) {
        titleLabel.text = item.title
        detailLabel.text = item.detail
        setNeedsLayout()
    }
}

// MARK: - 小工具
private extension CellView {
    
    /// 讀取Nib畫面 => 加到View上面
    func initViewFromXib() {
        
        let bundle = Bundle.main
        let name = String(describing: CellView.self)
        
        bundle.loadNibNamed(name, owner: self, options: nil)
        contentView.frame = bounds
        
        addSubview(contentView)
    }
}
