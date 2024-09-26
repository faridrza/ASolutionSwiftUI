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
        VStack(spacing: 20) {
            Text("Transfer Funds")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                HStack {
                    Text("From:")
                        .font(.headline)
                    Spacer()
                    Text("**** **** **** \(viewModel.senderDebitCard.cardNumber.suffix(4))")
                        .font(.subheadline)
                }
                .padding(.horizontal)

                HStack {
                    Text("Balance:")
                        .font(.headline)
                    Spacer()
                    Text("\(viewModel.senderDebitCard.balance, specifier: "%.2f") AZN")
                        .font(.subheadline)
                }
                .padding(.horizontal)

                Picker("To:", selection: $viewModel.selectedReceiverCard) {
                    Text("Select Card").tag(Optional<DebitCard>(nil))
                    ForEach(viewModel.receiverCards) { card in
                        Text("**** **** **** \(card.cardNumber.suffix(4))")
                            .tag(Optional(card))
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal)

                TextField("Amount", text: $viewModel.transferAmountText)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }

            Spacer()

            Button(action: {
                viewModel.startTransfer()
            }) {
                Text("Transfer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .padding()
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Notice"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }
}
