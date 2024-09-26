//
//  CardListView.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import SwiftUI

struct CardListView: View {
    @ObservedObject var viewModel = CardListViewModel()

    @State private var showingAddCardAlert = false
    @State private var newCardNumber = ""
    @State private var selectedCardDeletion: CardDeletion? = nil
    @State private var showingOtherReasonAlert = false
    @State private var customReasonText = ""

    var body: some View {
        List {
            ForEach(Array(viewModel.cardList.enumerated()), id: \.element.id) { index, cardViewModel in
                CardListItemView(viewModel: cardViewModel)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            selectedCardDeletion = CardDeletion(id: index)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
        .navigationTitle("Card List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddCardAlert = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
        .alert(item: $viewModel.errorMessage) { message in
            Alert(title: Text(message.title), message: Text(message.message), dismissButton: .default(Text("OK")))
        }
        .alert(item: $viewModel.successMessage) { message in
            Alert(title: Text(message.title), message: Text(message.message), dismissButton: .default(Text("OK")))
        }
        .alert("Add New Card", isPresented: $showingAddCardAlert, actions: {
            TextField("Enter card number", text: $newCardNumber)
                .keyboardType(.numberPad)
            Button("Add") {
                viewModel.addDebitCard(newCardNumber)
                newCardNumber = ""
            }
            Button("Cancel", role: .cancel) {
                newCardNumber = ""
            }
        }, message: {
            Text("Please enter your card 16 digits numbers")
        })
        .actionSheet(item: $selectedCardDeletion) { deletion in
            ActionSheet(
                title: Text("Select Reason"),
                message: Text("Please select a reason for deleting the card."),
                buttons: DeletionReason.allCases.map { reason in
                    .default(Text(reason.description)) {
                        if reason == .other {
                            showingOtherReasonAlert = true
                        } else {
                            viewModel.removeDebitCard(at: deletion.id, reason: reason)
                        }
                    }
                } + [.cancel()]
            )
        }
        .alert("Other Reason", isPresented: $showingOtherReasonAlert, actions: {
            TextField("Enter reason here", text: $customReasonText)
                .keyboardType(.default)
            Button("Delete", role: .destructive) {
                if !customReasonText.isEmpty, let deletion = selectedCardDeletion {
                    viewModel.removeDebitCard(at: deletion.id, customReason: customReasonText)
                    customReasonText = ""
                    selectedCardDeletion = nil
                } else {
                    viewModel.errorMessage = AlertMessage(title: "Error", message: "Please enter a reason.")
                }
            }
            Button("Cancel", role: .cancel) {
                customReasonText = ""
                selectedCardDeletion = nil
            }
        }, message: {
            Text("Please specify the reason for deleting the card.")
        })
    }
}

struct CardDeletion: Identifiable {
    let id: Int
}

struct CardListItemView: View {
    @ObservedObject var viewModel: CardListItemViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("**** \(viewModel.cardNumber.suffix(4))")
                    .foregroundColor(.black.opacity(0.6))
                Text(viewModel.balanceText)
                    .foregroundColor(.black)
            }
            Spacer()
            NavigationLink(destination: TransferView(viewModel: TransferViewModel(senderDebitCard: viewModel.debitCard))) {
                Text("Transfer")
                    .font(AppFonts.button)
                    .foregroundColor(.white)
                    .padding()
                    .background(AppColors.primary)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(AppColors.background)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}