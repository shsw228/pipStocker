//
//  ShareViewController.swift
//  pipStocker-extension
//
//  Created by Kengo Tate on 2022/10/09.
//

import UIKit
import Social
import MobileCoreServices
import UniformTypeIdentifiers

class ShareViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        store()
        
    }
    
    @IBAction func tapMoveAppButton(_ sender: Any) {
        store()
    }
    
    //データを保存
    private func store(){
        print("[extension]:Store")
        receiveInfo()
    }
    //　モーダルを閉じる
    private func dismissModal() {
        self.extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
    }
    
    private func receiveInfo() {
        
        guard let extensionItem: NSExtensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProviders = extensionItem.attachments else {
            let error = NSError(domain: Bundle.main.bundleIdentifier!, code: 0, userInfo: nil)
            // cancelRequestで呼び出し元にエラー通知し、共有画面を終了する
            self.extensionContext?.cancelRequest(withError: error)
            return
        }
        // URL を取得する
        let identifier = String(UTType.text.identifier)
        print("identifer:\(identifier)")
        guard let urlProvider = itemProviders.first(where: { $0.hasItemConformingToTypeIdentifier(identifier)}) else {
            let error = NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error description"])
            self.extensionContext?.cancelRequest(withError: error)
            return
        }
        urlProvider.loadItem(forTypeIdentifier: identifier, options: nil, completionHandler: { [weak self] (item, error) in
            // item に格納されている
            
            guard let string = item as? String else { return }
            let result = string.yahooTranditExchangeTrim()
            self?.save(string: result)
            // 最後にこれを呼ばないとフリーズする
            
            self?.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        })
    }
        private func save (string:String) {
            // AppGroups に設定したもの
            let suiteName = "group.com.hume.pipStocker"
            let key = "shareKey"
            let userDefaults = UserDefaults(suiteName: suiteName)
            userDefaults?.set(string, forKey: key)
    
        }
    
}
