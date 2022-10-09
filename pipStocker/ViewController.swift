//
//  ViewController.swift
//  pipStocker
//
//  Created by Kengo Tate on 2022/10/09.
//

import UIKit
import UIPiPView

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    
    @IBOutlet weak var pipView: UIPiPView!
    
    
    @IBAction func tapStartPipView(_ sender: UIButton) {
        print("\(#function)")
        togglePipView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        
        setStoredLabel()
    }
    @objc private func didBecomeActive(_ notification: Notification) {
        setStoredLabel()
    }
    //TODO: Extensionに切り出す
    private func setStoredLabel() {
        // AppGroups に設定したもの
        let suiteName = "group.com.hume.pipStocker"
        let key = "shareKey"
        let userDefaults = UserDefaults(suiteName: suiteName)
        let value = userDefaults?.string(forKey: key)
        label.text = value
    }
    private func togglePipView() {
        if (!pipView.isPictureInPictureActive()) {
            pipView.startPictureInPictureWithManualCallRender()
        }else {
            pipView.stopPictureInPicture()
        }
    }
    
}

