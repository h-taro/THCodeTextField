//
//  File.swift
//  
//
//  Created by 平石　太郎 on 2022/12/06.
//

import Foundation

extension String {
    func isBackspace() -> Bool {
        guard let char = self.cString(using: .utf8) else { return false }
        return strcmp(char, "\\b") == -92
    }
}
