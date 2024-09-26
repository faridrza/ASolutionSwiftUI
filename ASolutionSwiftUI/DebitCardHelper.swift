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
        return self.customer.debitCards.reversed()
    }

    private init() {
        customer = CustomerHelper.shared.getCustomer()
    }

    func addDebitCardToCustomer(_ debitCard: DebitCard) {
        customer.debitCards.append(debitCard)
    }

    func removeDebitCardFromCustomer(_ cardNumber: String, reason: String) {
        if let index = customer.debitCards.firstIndex(where: { $0.cardNumber == cardNumber }) {
            customer.debitCards.remove(at: index)
            // Handle the reason if needed
            print("Card \(cardNumber) removed for reason: \(reason)")
        }
    }

    func startTransaction(sender: DebitCard, receiverCardNumber: String, amount: Double) -> DebitCardTransactionResult {
        guard let senderIndex = customer.debitCards.firstIndex(where: { $0.cardNumber == sender.cardNumber }) else {
            return .receiverNotFounded
        }
        
        guard let receiverIndex = customer.debitCards.firstIndex(where: { $0.cardNumber == receiverCardNumber }) else {
            return .receiverNotFounded
        }
        
        var senderCard = customer.debitCards[senderIndex]
        var receiverCard = customer.debitCards[receiverIndex]
        
        if amount <= senderCard.balance {
            senderCard.balance -= amount
            receiverCard.balance += amount
            customer.debitCards[senderIndex] = senderCard
            customer.debitCards[receiverIndex] = receiverCard
            return .success
        } else {
            return .senderAmountInsufficient
        }
    }
}

enum DebitCardTransactionResult {
    case success
    case receiverNotFounded
    case senderAmountInsufficient
}