//
//  CardListViewModel.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import Foundation
import Combine

class CardListViewModel: ObservableObject {
    @Published var cardList: [DebitCard] = []
    @Published var errorMessage: String? = nil
    @Published var showErrorAlert: Bool = false
    
    private var debitCardHelper: DebitCardHelper
    
    init(debitCardHelper: DebitCardHelper = .shared) {
        self.debitCardHelper = debitCardHelper
        fetchData()
    }
    
    func fetchData() {
        cardList = debitCardHelper.debitCards
    }
    
    func addDebitCard(_ cardNumber: String) {
        let trimmedCardNumber = cardNumber.removeWhiteSpaces()
        let isValidCardNumber = trimmedCardNumber.count == 16 && trimmedCardNumber.allSatisfy({ $0.isNumber })
        
        guard isValidCardNumber else {
            errorMessage = "Card number must be 16 digits."
            showErrorAlert = true
            return
        }
        
        let isDuplicate = debitCardHelper.debitCards.contains { $0.cardNumber == trimmedCardNumber }
        
        guard !isDuplicate else {
            errorMessage = "A card with this number already exists."
            showErrorAlert = true
            return
        }
        
        let debitCard = DebitCard(cardNumber: trimmedCardNumber)
        debitCardHelper.addDebitCardToCustomer(debitCard)
        fetchData()
    }
    
    func removeDebitCard(at offsets: IndexSet) {
        offsets.forEach { index in
            let cardNumber = cardList[index].cardNumber
            debitCardHelper.removeDebitCardFromCustomer(cardNumber)
        }
        fetchData()
    }
}
