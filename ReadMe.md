# WWSwiftUI+List
[![Swift-5.7](https://img.shields.io/badge/Swift-5.7-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-16.0](https://img.shields.io/badge/iOS-16.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![TAG](https://img.shields.io/github/v/tag/William-Weng/WWSwiftUI_List) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

### [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- [Transfer SwiftUI's List to UIKit.](https://www.appcoda.com.tw/swiftui-expandable-list-view/)
- [將SwiftUI的List轉給UIKit使用。](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/設定-swiftui-list-的-row-有多個可點選的區塊-利用-buttonstyle-emptyview-dd453993338f)

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```bash
dependencies: [
    .package(url: "https://github.com/William-Weng/WWSwiftUI_List.git", .upToNextMajor(from: "0.5.0"))
]
```

### 可用函式 (Function)
|函式|功能|
|-|-|
|init(items:cellProvider:)|初始化|
|reloadData(_:)|更新項目數值|

### Example
```swift
import UIKit
import WWSwiftUI_MultiDatePicker
import WWSwiftUI_List

class ViewController: UIViewController {
    
    private var list: WWSwiftUI.List<CellViewUI>!
    
    private var items: [CellItem] = [
        .init(title: "預覽標題1", detail: "預覽內容1"),
        .init(title: "預覽標題2", detail: "預覽內容2")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = WWSwiftUI.List(items: items) { CellViewUI() }
        list.move(toParent: self, on: view)
    }
    
    @IBAction func refreashItem(_ sender: UIBarButtonItem) {
        
        items = [
            .init(
                title: "吉伊卡哇",
                detail: "《吉伊卡哇》（日語：ちいかわ，意味「小可愛」），副標題《這又小又可愛的傢伙》（日語：なんか小さくてかわいいやつ），是由日本漫畫家nagano創作的漫畫系列[5]。該系列自2020年1月起透過X（原Twitter）進行連載，並由講談社出版單行本。"),
            .init(
                title: "9款吉伊卡哇週邊商品及2024聯名新品精選！",
                detail: "日本漫畫家ナガノ創作的漫畫「吉伊卡哇/ちいかわ」伴隨電視動畫推出後，人氣與知名度又大大增加，雖然台灣還沒有電視台正式引進，但許多喜愛日本流行可愛文化的人，也都已經認識「吉伊卡哇/ちいかわ」甚至被圈粉，以下就精選9款日本開賣的吉伊卡哇週邊商品及2024年聯名新品，如果剛好去旅遊的，可以找看看。(NEWii官網)")
        ]
        
        list.reloadData(items)
    }
}
```
