//
//  CounterView.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import SwiftUI

struct CounterView: View {

    @ObservedObject var store: Store<AppState, AppAction>
    @State var showIsThisPrimeModal = false
    @State var alertNthPrime: Int?
    @State var isNthPrimeButtonDisabled = false

    var WN = WolframNetworking()

    var body: some View {
        VStack {
            HStack {
                Button(action: { self.store.send(.counter(.decrTapped)) })
                { Text("-") }

                Text(store.value.count.description)
                
                Button(action: { self.store.send(.counter(.incrTapped)) })
                { Text("+") }
            }

            Button(action: { self.showIsThisPrimeModal = true })
            { Text("Is this prime?") }

            Button(action: { self.nthPrimeButtonAction() })
                { Text("What is the \(ordinal(store.value.count)) prime?") }
            .disabled(isNthPrimeButtonDisabled)
        }
        .font(.title)
        .navigationBarTitle("Counter demo")
        .sheet(isPresented: $showIsThisPrimeModal) { IsThisPrimeModal(store: self.store) }
        .alert(item: $alertNthPrime) { n in
            Alert(title: Text("The \(ordinal(self.store.value.count)) prime is \(n)"), dismissButton: Alert.Button.default(Text("Ok")))
        }
    }

    private func nthPrimeButtonAction() {
        isNthPrimeButtonDisabled = true
        WN.nthPrime(store.value.count) { prime in
            self.alertNthPrime = prime
            self.isNthPrimeButtonDisabled = false
        }
    }

    private func ordinal(_ n: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: n)) ?? ""
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(store: Store(initialValue: AppState(),
                                 reducer: appReducer))
    }
}
