//
//  CardListItemViewModel.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation
import Combine

class CardListItemViewModel: ObservableObject, Identifiable {
    let id = UUID()
    private(set) var debitCard: DebitCard

    var cardNumber: String {
        return debitCard.cardNumber
    }

    var balanceText: String {
        return "\(debitCard.balance) AZN"
    }

    init(debitCard: DebitCard) {
        self.debitCard = debitCard
    }
}