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
    @State private var showingDatePicker = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)

            Button(action: {
                showingDatePicker = true
            }) {
                HStack {
                    Text(date.formattedString)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
            }
            .sheet(isPresented: $showingDatePicker) {
                VStack {
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .padding()
                    Button("Done") {
                        showingDatePicker = false
                    }
                    .padding()
                }
            }
        }
        .padding(.horizontal)
    }
}
