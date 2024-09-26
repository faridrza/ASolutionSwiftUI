//
//  TransferViewModel.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation
import Combine

class TransferViewModel: ObservableObject {
    @Published var senderDebitCard: DebitCard
    @Published var receiverCards: [DebitCard] = []
    @Published var selectedReceiverCard: DebitCard?
    @Published var transferAmountText: String = ""
    @Published var errorMessage: String? = nil
    @Published var showErrorAlert: Bool = false

    private var transferAmount: Double {
        Double(transferAmountText) ?? 0.0
    }

    private var debitCardHelper: DebitCardHelper

    init(senderDebitCard: DebitCard, debitCardHelper: DebitCardHelper = .shared) {
        self.senderDebitCard = senderDebitCard
        self.debitCardHelper = debitCardHelper
        fetchReceiverCards()
    }

    func fetchReceiverCards() {
        receiverCards = debitCardHelper.debitCards.filter { $0.cardNumber != senderDebitCard.cardNumber }
    }

    func startTransfer() {
        guard let receiverCard = selectedReceiverCard else {
            errorMessage = "Please select a receiver card."
            showErrorAlert = true
            return
        }

        guard transferAmount > 0 else {
            errorMessage = "Please enter a valid amount."
            showErrorAlert = true
            return
        }

        let result = debitCardHelper.startTransaction(
            sender: senderDebitCard,
            receiverCardNumber: receiverCard.cardNumber,
            amount: transferAmount
        )

        switch result {
        case .success:
            if let updatedSenderCard = debitCardHelper.debitCards.first(where: { $0.id == senderDebitCard.id }) {
                senderDebitCard = updatedSenderCard
            }
            errorMessage = "Transfer successful."
            showErrorAlert = true
            transferAmountText = ""
            selectedReceiverCard = nil
            fetchReceiverCards()
        default: break
            // Handle errors
        }
    }
}
