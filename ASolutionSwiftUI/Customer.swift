//
//  Customer.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation

struct Customer: Identifiable {
    let id = UUID()
    let name: String
    let surname: String
    let birthDate: String
    let gsmNumber: String
    var debitCards: [DebitCard] = []
}