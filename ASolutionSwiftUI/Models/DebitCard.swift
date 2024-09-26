//
//  DebitCard.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation
import Combine

class DebitCard: ObservableObject, Identifiable, Hashable {
    let id = UUID()
    let cardNumber: String
    @Published var balance: Double

    init(cardNumber: String, balance: Double = 10) {
        self.cardNumber = cardNumber
        self.balance = balance
    }

    static func == (lhs: DebitCard, rhs: DebitCard) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
