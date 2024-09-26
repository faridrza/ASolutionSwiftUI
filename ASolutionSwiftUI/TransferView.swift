//
//  TransferView.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import SwiftUI

struct TransferView: View {
    @ObservedObject var viewModel: TransferViewModel

    var body: some View {
        VStack(spacing: 16) {
            LabelledTextField(
                title: "Sender",
                text: .constant(viewModel.senderDebitCard.cardNumber),
                placeholder: ""
            )
            .disabled(true)

            LabelledTextField(
                title: "Balance",
                text: .constant("\(viewModel.senderDebitCard.balance) AZN"),
                placeholder: ""
            )
            .disabled(true)

            VStack(alignment: .leading, spacing: 4) {
                Text("Receiver")
                    .font(AppFonts.body)
                    .foregroundColor(AppColors.textSecondary)
                Picker("Receiver", selection: $viewModel.selectedReceiverCard) {
                    Text("Please choose receiver card").tag(Optional<DebitCard>(nil))
                    ForEach(viewModel.receiverCards) { card in
                        Text(card.cardNumber).tag(Optional(card))
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .background(AppColors.background)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            }

            LabelledTextField(
                title: "Amount",
                text: $viewModel.transferAmountText,
                placeholder: "Please enter amount",
                keyboardType: .decimalPad
            )

            Button(action: {
                viewModel.startTransfer()
            }) {
                Text("Transfer")
                    .font(AppFonts.button)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(AppColors.primary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Transfer between my cards")
        .alert(item: $viewModel.errorMessage) { message in
            Alert(title: Text(message.title), message: Text(message.message), dismissButton: .default(Text("OK")))
        }
        .alert(item: $viewModel.successMessage) { message in
            Alert(title: Text(message.title), message: Text(message.message), dismissButton: .default(Text("OK")))
        }
    }
}