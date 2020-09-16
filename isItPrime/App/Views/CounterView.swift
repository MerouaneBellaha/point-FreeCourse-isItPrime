//
//  CounterView.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import SwiftUI

struct CounterView: View {

    @ObservedObject var state: AppState
    @State var showIsThisPrimeModal = false
    @State var alertNthPrime: Int?
    var WN = WolframNetworking()

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.state.count -= 1
                }) { Text("-") }

                Text(state.count.description)
                
                Button(action: {
                    self.state.count += 1
                }) { Text("+") }
            }

            Button(action: {
                self.showIsThisPrimeModal = true
            }) { Text("Is this prime?") }

            Button(action: {
                self.WN.nthPrime(self.state.count) { prime in
                    self.alertNthPrime = prime
                }
            }) {  Text("What is the \(ordinal(state.count)) prime?") }
        }
        .font(.title)
        .navigationBarTitle("Counter demo")
        .sheet(isPresented: $showIsThisPrimeModal) { IsThisPrimeModal(state: self.state) }
        .alert(item: $alertNthPrime) { n in
            Alert(title: Text("The \(ordinal(self.state.count)) prime is \(n)"), dismissButton: Alert.Button.default(Text("Ok")))
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
        CounterView(state: AppState())
    }
}


extension Int: Identifiable {
    public var id: String {
        self.description
    }
}
