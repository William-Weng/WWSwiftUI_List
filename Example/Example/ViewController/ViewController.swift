//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2026/1/28.
//

import UIKit
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_List
import SwiftUICore

final class ViewController: UIViewController {
    
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
            .init(type: TrailingSwipeType.delete.rawValue, title: "Delete", role: .destructive, tintColor: .red),
            .init(type: TrailingSwipeType.edit.rawValue, title: "Edit", role: .none, tintColor: .blue)
        ]
        
        list = WWSwiftUI.List(items: items) { CellViewUI() }
        list.move(toParent: self, on: view)
        list.delegate = self
        list.leadingConfigures(configures)
        
        items = [
            .init(title: "Title - 1", detail: "Detail - 1"),
            .init(title: "Title - 2", detail: "Detail - 2")
        ]
    }
    
    @IBAction func refreashItem(_ sender: UIBarButtonItem) {
        
        let item: CellItem = .init(
            title: "SwiftUI - \(Date.now)",
            detail: "SwiftUI helps you build great-looking apps across all Apple platforms with the power of Swift — and surprisingly little code. You can bring even better experiences to everyone, on any Apple device, using just one set of tools and APIs.")
       
        list.appendItem(with: item)
    }
}

// MARK: - WWSwiftUI.ListDelegate
extension ViewController: WWSwiftUI.ListDelegate {
    
    func list<Cell>(_ list: WWSwiftUI.List<Cell>, didSelectedAt index: Int, item: Cell.Item) {
        guard let item = item as? CellViewUI.Item else { return }
        title = item.title
    }
    
    func list<Cell>(_ list: WWSwiftUI.List<Cell>, swipeAction type: Int, edge: HorizontalEdge, didSelectedAt index: Int, item: Cell.Item) {
        
        guard let item = item as? CellViewUI.Item,
              let type = TrailingSwipeType(rawValue: type)
        else {
            return
        }
        
        switch type {
        case .delete:
            list.removeItem(at: index)
        case .edit:
            let editItem = CellViewUI.Item(title: "Edit", detail: "Edit detail - \(item.detail)")
            list.editItem(editItem as! Cell.Item, at: index)
        }
    }
}
