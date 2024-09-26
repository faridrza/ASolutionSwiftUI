//
//  CustomerHelper.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation

class CustomerHelper {
    static let shared = CustomerHelper()

    private var customer: Customer?

    func createCustomer(with model: Customer) {
        customer = model
    }

    func getCustomer() -> Customer {
        return customer ?? Customer(name: "", surname: "", birthDate: "", gsmNumber: "")
    }
}
