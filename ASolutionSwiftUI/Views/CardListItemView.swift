//
//  CardListItemView.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import SwiftUI

struct CardListItemView: View {
    @ObservedObject var card: DebitCard

    var body: some View {
        HStack {
            Text("**** **** **** \(card.cardNumber.suffix(4))")
                .font(.headline)
            Spacer()
            Text("\(card.balance, specifier: "%.2f") AZN")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}