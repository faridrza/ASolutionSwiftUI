//
//  DashboardViewModel.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation
import Combine

class DashboardViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var birthdate: Date = Date()
    @Published var phoneNumber: String = "+994"
    @Published var isCreateButtonEnabled: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupBindings()
    }
    
    private func validateInputs() {
        let isValidName = !name.isEmpty
        let isValidSurname = !surname.isEmpty

        // Calculate the age
        let ageComponents = Calendar.current.dateComponents([.year], from: birthdate, to: Date())
        let age = ageComponents.year ?? 0
        let isValidBirthdate = age >= 18

        let cleanedPhoneNumber = phoneNumber.filter { $0.isNumber }
        let isValidPhoneNumber = cleanedPhoneNumber.count == 11 // "+994" + 9 digits

        let isValid = isValidName && isValidSurname && isValidBirthdate && isValidPhoneNumber

        DispatchQueue.main.async {
            self.isCreateButtonEnabled = isValid
        }
    }

    func createCustomer() {
        let customer = Customer(
            name: name,
            surname: surname,
            birthDate: birthdate.formattedString,
            gsmNumber: phoneNumber
        )
        CustomerHelper.shared.createCustomer(with: customer)
    }

    private func setupBindings() {
        Publishers.CombineLatest4($name, $surname, $phoneNumber, $birthdate)
            .sink { [weak self] _, _, _, _ in
                self?.validateInputs()
            }
            .store(in: &cancellables)
    }
}
