//
//  DatePickerField.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import SwiftUI

struct DatePickerField: View {
    let title: String
    @Binding var date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(AppFonts.body)
                .foregroundColor(AppColors.textSecondary)
            DatePicker(
                "",
                selection: $date,
                in: ...Date.maximumBirthDate,
                displayedComponents: .date
            )
            .datePickerStyle(CompactDatePickerStyle())
            .labelsHidden()
            .frame(maxHeight: 400)
        }
    }
}