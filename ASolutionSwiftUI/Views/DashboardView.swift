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
            VStack(spacing: 20) {
                Spacer()

                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                VStack(spacing: 16) {
                    TextField("Name", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    TextField("Surname", text: $viewModel.surname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    DatePickerField(title: "Birthdate", date: $viewModel.birthdate)

                    TextField("Phone Number", text: $viewModel.phoneNumber)
                        .keyboardType(.phonePad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }

                Spacer()

                Button(action: {
                    viewModel.createCustomer()
                    navigateToCardList = true
                }) {
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(viewModel.isCreateButtonEnabled ? Color.blue : Color.gray)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(!viewModel.isCreateButtonEnabled)
                .padding(.bottom)

                NavigationLink(destination: CardListView(), isActive: $navigateToCardList) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
