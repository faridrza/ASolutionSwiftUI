//
//  CardListView.swift
//  ASolutionSwiftUI
//
//  Created by Farid Rzayev on 26.09.24.
//


import SwiftUI

struct CardListView: View {
    @ObservedObject var viewModel = CardListViewModel()
    @State private var showingAddCardSheet = false
    @State private var newCardNumber = ""

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.cardList) { card in
                    NavigationLink(destination: TransferView(viewModel: TransferViewModel(senderDebitCard: card))) {
                        CardListItemView(card: card)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("My Cards")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddCardSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddCardSheet) {
            AddCardView { cardNumber in
                viewModel.addDebitCard(cardNumber)
                showingAddCardSheet = false
            }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddCardView: View {
    @State private var cardNumber: String = ""
    var onAdd: (String) -> Void

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter 16-digit card number", text: $cardNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    onAdd(cardNumber)
                }) {
                    Text("Add Card")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(cardNumber.count != 16)

                Spacer()
            }
            .navigationTitle("Add New Card")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        onAdd("")
                    }
                }
            }
        }
    }
}

