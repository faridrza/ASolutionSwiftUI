//
//  DebitCard.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation

struct DebitCard: Identifiable, Hashable {
    let id = UUID()
    let cardNumber: String
    var balance: Double

    init(cardNumber: String, balance: Double = 10) {
        self.cardNumber = cardNumber
        self.balance = balance
    }
}