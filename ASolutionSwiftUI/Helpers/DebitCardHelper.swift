//
//  DebitCardHelper.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation

class DebitCardHelper {
    static let shared = DebitCardHelper()

    private var customer: Customer

    var debitCards: [DebitCard] {
        return customer.debitCards
    }

    private init() {
        customer = CustomerHelper.shared.getCustomer()
    }

    func addDebitCardToCustomer(_ debitCard: DebitCard) {
        customer.debitCards.append(debitCard)
    }

    func removeDebitCardFromCustomer(_ cardNumber: String) {
        if let index = customer.debitCards.firstIndex(where: { $0.cardNumber == cardNumber }) {
            customer.debitCards.remove(at: index)
        }
    }

    func startTransaction(sender: DebitCard, receiverCardNumber: String, amount: Double) -> DebitCardTransactionResult {
        guard let senderIndex = customer.debitCards.firstIndex(where: { $0.id == sender.id }),
              let receiverIndex = customer.debitCards.firstIndex(where: { $0.cardNumber == receiverCardNumber }) else {
            return .receiverNotFound
        }

        if amount <= customer.debitCards[senderIndex].balance {
            customer.debitCards[senderIndex].balance -= amount
            customer.debitCards[receiverIndex].balance += amount
            return .success
        } else {
            return .senderAmountInsufficient
        }
    }
}

enum DebitCardTransactionResult {
    case success
    case receiverNotFound
    case senderAmountInsufficient
}
