//
//  LabelledTextField.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import SwiftUI

struct LabelledTextField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    var isDisabled: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(AppFonts.body)
                .foregroundColor(AppColors.textSecondary)
            TextField(placeholder, text: $text)
                .font(AppFonts.body)
                .padding()
                .background(AppColors.background)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                .frame(height: 48)
                .keyboardType(keyboardType)
                .disabled(isDisabled)
        }
    }
}