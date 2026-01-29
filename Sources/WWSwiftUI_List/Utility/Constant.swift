//
//  Constant.swift
//  WWSwiftUI_List
//
//  Created by William.Weng on 2026/1/28.
//

import SwiftUI
import WWSwiftUI_MultiDatePicker

// MARK: - typealias
public extension WWSwiftUI {
    
    /// 滑動選單
    struct SwipeButtonConfigure {
        
        let type: Int           // 類型
        let title: String       // 標題
        let role: ButtonRole?   // 規則
        let tintColor: Color?   // 底色
        
        public init(type: Int, title: String, role: ButtonRole?, tintColor: Color?) {
            self.type = type
            self.title = title
            self.role = role
            self.tintColor = tintColor
        }
    }
}
