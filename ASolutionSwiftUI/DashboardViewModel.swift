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
    @Published var birthdate: Date? = nil
    @Published var rawPhoneNumber: String = "+994"

    @Published var isCreateButtonEnabled: Bool = false
    @Published var formattedPhoneNumber: String = "+994"

    private let phoneNumberFormatter = PhoneNumberFormatter()

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupBindings()
    }

    func createCustomer() {
        let customer = Customer(
            name: name,
            surname: surname,
            birthDate: birthdate?.formattedString ?? "",
            gsmNumber: rawPhoneNumber
        )
        CustomerHelper.shared.createCustomer(with: customer)
    }

    private func setupBindings() {
        Publishers.CombineLatest4($name, $surname, $birthdate, $rawPhoneNumber)
            .sink { [weak self] _, _, _, _ in
                self?.validateInputs()
            }
            .store(in: &cancellables)

        $rawPhoneNumber
            .sink { [weak self] _ in
                self?.formatPhoneNumber()
            }
            .store(in: &cancellables)
    }

    private func validateInputs() {
        let cleanedPhoneNumber = PhoneHelper.cleanPhoneNumber(number: rawPhoneNumber)
        let isValidPhoneNumber = cleanedPhoneNumber.count == 12 // "+994" + 9 digits
        let isValid = !name.isEmpty &&
            !surname.isEmpty &&
            birthdate != nil &&
            isValidPhoneNumber
        DispatchQueue.main.async {
            self.isCreateButtonEnabled = isValid
        }
    }

    private func formatPhoneNumber() {
        let formatted = phoneNumberFormatter.fullFormat(phone: rawPhoneNumber)
        DispatchQueue.main.async {
            self.formattedPhoneNumber = formatted
        }
    }
}