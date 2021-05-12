//
//  AddExpense.swift
//  iExpense
//
//  Created by Ufuk Angay on 29/04/2021.
//

import Foundation
import SwiftUI

struct AddView : View{
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses

    @State private var name = ""
    @State private var type = ""
    @State private var amount = ""

    static let types = ["Rent", "Cloting", "Exchange"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount (€)", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
