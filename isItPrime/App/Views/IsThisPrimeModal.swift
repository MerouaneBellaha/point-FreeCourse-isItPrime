//
//  IsThisPrimeModal.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import SwiftUI

struct IsThisPrimeModal: View {

    @ObservedObject var state: AppState

    var body: some View {

        ZStack {
            isPrime(state.count) ?
                AnyView(PrimeView(state: state)) :
                AnyView(Text("\(state.count) is not Prime"))
        }
        .font(.title)
    }

    private func isPrime(_ p: Int) -> Bool {
        if p <= 1 { return false }
        if p <= 3 { return true }
        for i in 2...Int(sqrt(Float(p))) {
            if p % i == 0 { return false }
        }
        return true
    }
}

struct IsThisPrimeModal_Previews: PreviewProvider {
    static var previews: some View {
        IsThisPrimeModal(state: AppState())
    }
}

struct PrimeView: View {

    @ObservedObject var state: AppState
    var isFavorite: Bool { state.favoritePrimes.contains(state.count) }

    var body: some View {
        VStack {
            Text("\(state.count.description) is Prime 🔥")
            Button(action: {
                self.manageFavoritesPrimeArray()
            }) {
                Text(isFavorite ?
                    "Remove from favorite Primes" :
                    "Add to favorite Primes")
            }
        }
    }

    private func manageFavoritesPrimeArray() {
        isFavorite ?
            state.favoritePrimes.removeAll(where: { $0 == self.state.count}) :
            state.favoritePrimes.append(self.state.count)
    }
}

struct NotPrimeView: View {
    var body: some View {
        Text("This is not a Prime")
    }
}
