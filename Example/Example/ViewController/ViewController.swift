//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2026/1/28.
//

import UIKit
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_List

class ViewController: UIViewController {
    
    private enum TrailingSwipeType: Int {
        case delete
        case edit
    }
    
    private var list: WWSwiftUI.List<CellViewUI>!
    
    private var items: [CellViewUI.Item] = [] {
        didSet { list.reloadData(items) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configures: [WWSwiftUI.SwipeButtonConfigure] = [
            .init(type: TrailingSwipeType.delete.rawValue, title: "刪除", role: .destructive, tintColor: .red),
            .init(type: TrailingSwipeType.edit.rawValue, title: "編輯", role: .none, tintColor: .blue)
        ]
        
        list = WWSwiftUI.List(items: items, trailingConfigures: configures) { CellViewUI() }
        list.delegate = self
        list.move(toParent: self, on: view)
        
        items = [
            .init(title: "預覽標題1", detail: "預覽內容1"),
            .init(title: "預覽標題2", detail: "預覽內容2")
        ]
    }
    
    @IBAction func refreashItem(_ sender: UIBarButtonItem) {
        
        let item: CellItem = .init(
            title: "9款吉伊卡哇週邊商品及2024聯名新品精選！9款吉伊卡哇週邊商品及2024聯名新品精選！9款吉伊卡哇週邊商品及2024聯名新品精選！",
            detail: "日本漫畫家ナガノ創作的漫畫「吉伊卡哇/ちいかわ」伴隨電視動畫推出後，人氣與知名度又大大增加，雖然台灣還沒有電視台正式引進，但許多喜愛日本流行可愛文化的人，也都已經認識「吉伊卡哇/ちいかわ」甚至被圈粉，以下就精選9款日本開賣的吉伊卡哇週邊商品及2024年聯名新品，如果剛好去旅遊的，可以找看看。(NEWii官網)")
       
        items.append(item)
    }
}

// MARK: - WWSwiftUI.ListDelegate
extension ViewController: WWSwiftUI.ListDelegate {
    
    func list<Cell>(_ list: WWSwiftUI.List<Cell>, trailingSwipe type: Int, didSelectedAt index: Int, item: Cell.Item) {
        
        guard let item = item as? CellViewUI.Item,
              let type = TrailingSwipeType(rawValue: type)
        else {
            return
        }
        
        switch type {
        case .delete: items.remove(at: index)
        case .edit: items[index] = .init(title: "\(Date.now)", detail: item.detail)
        }
    }
}
