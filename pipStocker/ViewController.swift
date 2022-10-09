//
//  ViewController.swift
//  pipStocker
//
//  Created by Kengo Tate on 2022/10/09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    
    @IBAction func tapStartPipView(_ sender: Any) {
        print("\(#function)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        
        setStoredLabel()
    }
    @objc private func didBecomeActive(_ notification: Notification) {
        setStoredLabel()
    }
    private func setStoredLabel() {
        // AppGroups に設定したもの
        let suiteName = "group.com.hume.pipStocker"
        let key = "shareKey"
        let userDefaults = UserDefaults(suiteName: suiteName)
        let value = userDefaults?.string(forKey: key)
        label.text = value
    }
}

