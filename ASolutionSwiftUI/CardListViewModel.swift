//
//  CardListViewModel.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation
import Combine

class CardListViewModel: ObservableObject {
    @Published var cardList: [CardListItemViewModel] = []
    @Published var errorMessage: AlertMessage? = nil
    @Published var successMessage: AlertMessage? = nil

    private var debitCardHelper: DebitCardHelper

    init(debitCardHelper: DebitCardHelper = .shared) {
        self.debitCardHelper = debitCardHelper
        fetchData()
    }

    func fetchData() {
        cardList = debitCardHelper.debitCards.map { debitCard in
            CardListItemViewModel(debitCard: debitCard)
        }
    }

    func addDebitCard(_ cardNumber: String) {
        let trimmedCardNumber = cardNumber.removeWhiteSpaces()
        let nonDigitsCharacterSet = CharacterSet.decimalDigits.inverted
        let containsNonDigits = trimmedCardNumber.rangeOfCharacter(from: nonDigitsCharacterSet) != nil

        guard trimmedCardNumber.count == 16,
              !cardNumber.isEmpty,
              !containsNonDigits else {
            errorMessage = AlertMessage(title: "Error", message: "Card information must be 16 digits.")
            return
        }

        let isDuplicate = debitCardHelper.debitCards.contains { $0.cardNumber == cardNumber }

        guard !isDuplicate else {
            errorMessage = AlertMessage(title: "Error", message: "A card with this number already exists.")
            return
        }

        let debitCard = DebitCard(cardNumber: cardNumber)
        debitCardHelper.addDebitCardToCustomer(debitCard)
        fetchData()
        successMessage = AlertMessage(title: "Success", message: "Card has been added")
    }

    func getReceiverCardsExcluding(cardNumber: String) -> [DebitCard] {
        return debitCardHelper.debitCards.filter { $0.cardNumber != cardNumber }
    }

    func removeDebitCard(at index: Int, reason: DeletionReason? = nil, customReason: String? = nil) {
        let cardNumber = cardList[index].cardNumber
        let deletionReason = customReason ?? reason?.description ?? "No reason provided"
        debitCardHelper.removeDebitCardFromCustomer(cardNumber, reason: deletionReason)
        fetchData()
        successMessage = AlertMessage(title: "Success", message: "Selected card has been deleted.")
    }
}