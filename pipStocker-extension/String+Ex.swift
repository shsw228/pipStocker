//
//  String+Ex.swift
//  pipStocker-extension
//
//  Created by Kengo Tate on 2022/10/09.
//

import Foundation
extension String {
    
    func yahooTranditExchangeTrim() -> String {
        guard let index = self.firstIndex(of: "★") else {return ""}
        
            let prefix = self.prefix(upTo: index)
        
        // TODO: テンプレート的に「-」が30個並べられているのでもうハードコードした。正規表現でやりたい
            let array = prefix.components(separatedBy: "------------------------------")
            let subArray:[String] = array[2].components(separatedBy: "---")
        guard var firstObj = subArray.first else { return ""}
        firstObj.removeFirst(2) //行頭に残る改行文字を削除
        return firstObj
    }
}
