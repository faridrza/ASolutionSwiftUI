//
//  String+Ext.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//

import Foundation

extension String {
    func removeWhiteSpaces() -> String {
        return self.filter { !$0.isWhitespace }
    }
}
