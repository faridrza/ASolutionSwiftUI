//
//  DashboardView.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import SwiftUI

struct DashboardView: View {
    @ObservedObject private var viewModel = DashboardViewModel()
    @State private var navigateToCardList = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    LabelledTextField(
                        title: "Name",
                        text: $viewModel.name,
                        placeholder: "Please enter your name"
                    )
                    LabelledTextField(
                        title: "Surname",
                        text: $viewModel.surname,
                        placeholder: "Please enter your surname"
                    )
                    DatePickerField(
                        title: "Birthdate",
                        date: Binding(
                            get: { viewModel.birthdate ?? Date() },
                            set: { viewModel.birthdate = $0 }
                        )
                    )
                    LabelledTextField(
                        title: "Phone Number",
                        text: $viewModel.rawPhoneNumber,
                        placeholder: "Please enter your phone number",
                        keyboardType: .phonePad
                    )
                    .onChange(of: viewModel.formattedPhoneNumber) { newFormattedPhoneNumber in
                        if viewModel.rawPhoneNumber != newFormattedPhoneNumber {
                            viewModel.rawPhoneNumber = newFormattedPhoneNumber
                        }
                    }

                    NavigationLink(
                        destination: CardListView(),
                        isActive: $navigateToCardList
                    ) {
                        EmptyView()
                    }

                    Button(action: {
                        viewModel.createCustomer()
                        navigateToCardList = true
                    }) {
                        Text("Create Account")
                            .font(AppFonts.button)
                            .frame(maxWidth: .infinity, minHeight: 48)
                            .background(viewModel.isCreateButtonEnabled ? AppColors.primary : AppColors.primary.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!viewModel.isCreateButtonEnabled)
                    .padding(.top)
                }
                .padding()
            }
            .navigationTitle("Demo App")
            .background(AppColors.background)
        }
        .navigationViewStyle(.automatic)
    }
}
