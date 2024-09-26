//
//  String+Ext.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//

import Foundation

extension String {
    static let empty: String = ""

    func applyPatternOnNumbers(regex: String, mask: String, replacementCharacter: Character) -> String {
        let pureNumber = replacingOccurrences(of: regex, with: "", options: .regularExpression)
        var result = ""
        var pureNumberIndex = pureNumber.startIndex
        for patternCharacter in mask {
            guard pureNumberIndex < pureNumber.endIndex else {
                return result
            }
            if patternCharacter == replacementCharacter {
                result.append(pureNumber[pureNumberIndex])
                pureNumber.formIndex(after: &pureNumberIndex)
            } else {
                result.append(patternCharacter)
            }
        }
        return result
    }

    func textPattern(regex: String = "[^0-9]", mask: String = "#### #### #### ####") -> String {
        applyPatternOnNumbers(regex: regex, mask: mask, replacementCharacter: "#")
    }

    func removeWhiteSpaces() -> String {
        return self.filter { $0 != Character(" ") }
    }
}
