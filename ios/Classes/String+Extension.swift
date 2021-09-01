//
//  String+Extension.swift
//  pos_printer
//
//  Created by Yoyo on 9/1/21.
//

import Foundation

extension String {
    func imageFromBase64() -> UIImage? {
        guard let data = Data(base64Encoded: self) else { return nil }

        return UIImage(data: data)
    }
    
    func splitToLinesBy(length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map { i -> String in
            let _startIndex = self.index(self.startIndex, offsetBy: i)
            let _endIndex   = self.index(_startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[_startIndex..<_endIndex])
        }
    }
    
    func splitToLinesWrapWordBy(length: Int) -> [String] {
        let words = self.split(separator: " ")
        var newWords = [String]()
        for word in words {
            if word.count > length { // Length exceed the limit -> split
                newWords.append(contentsOf: String(word).splitToLinesBy(length: length))
            } else {
                newWords.append(String(word))
            }
        }
        
        var lines = [String]()
        var line = String()
        for (i, word) in newWords.enumerated() {
            if line.count + word.count <= length {
                line.append("\(word) ")
            } else if line.count > 0 {
                lines.append(String(line.dropLast())) //Remove last blank
                line = String("\(word) ")
            }
            
            if i == newWords.count - 1 && line.count > 0 {
                lines.append(String(line.dropLast())) //Remove last blank
            }
        }
        
        return lines
    }
}
