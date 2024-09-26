//
//  TransferViewModel.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation
import Combine

class TransferViewModel: ObservableObject {
    let senderDebitCard: DebitCard
    @Published var receiverCards: [DebitCard] = []
    @Published var selectedReceiverCard: DebitCard?
    @Published var transferAmountText: String = ""
    @Published var errorMessage: AlertMessage? = nil
    @Published var successMessage: AlertMessage? = nil

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
            errorMessage = AlertMessage(title: "Error", message: "Please select a receiver card.")
            return
        }

        if transferAmount <= 0 {
            errorMessage = AlertMessage(title: "Error", message: "Please enter a valid amount.")
            return
        }

        let result = debitCardHelper.startTransaction(
            sender: senderDebitCard,
            receiverCardNumber: receiverCard.cardNumber,
            amount: transferAmount
        )

        switch result {
        case .success:
            successMessage = AlertMessage(title: "Success", message: "Your transfer has been successful.")
            transferAmountText = ""
            selectedReceiverCard = nil
        case .receiverNotFounded:
            errorMessage = AlertMessage(title: "Error", message: "Receiver not found.")
        case .senderAmountInsufficient:
            errorMessage = AlertMessage(title: "Error", message: "Insufficient funds.")
        }
    }
}