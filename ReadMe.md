# WWSwiftUI+List
[![Swift-5.7](https://img.shields.io/badge/Swift-5.7-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-16.0](https://img.shields.io/badge/iOS-16.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![TAG](https://img.shields.io/github/v/tag/William-Weng/WWSwiftUI_List) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

### [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- [Transfer SwiftUI's List to UIKit.](https://www.appcoda.com.tw/swiftui-expandable-list-view/)
- [將SwiftUI的List轉給UIKit使用。](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/設定-swiftui-list-的-row-有多個可點選的區塊-利用-buttonstyle-emptyview-dd453993338f)

https://github.com/user-attachments/assets/38bb5433-1426-4e03-90e7-f48c2913b76f

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```bash
dependencies: [
    .package(url: "https://github.com/William-Weng/WWSwiftUI_List.git", .upToNextMajor(from: "0.5.2"))
]
```

### 可用函式 (Function)
|函式|功能|
|-|-|
|init(items:cellProvider:)|初始化|
|reloadData(_:)|更新項目數值|
|appendItem(with:animation:)|新增項目|
|removeItem(at:animation:)|刪除項目|
|editItem(_:at:animation:)|編譯項目|
|leadingConfigures(_:)|左側滑動選單設定|
|trailingConfigures(_:)|右側滑動選單設定|

### 可用函式 (Delegate)
|函式|功能|
|-|-|
|list(_:didSelectedAt:item:)|項目點選功能|
|list(_:swipeAction:edge:didSelectedAt:item:)|側邊滑動選單功能|

### Example
```swift
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
```
