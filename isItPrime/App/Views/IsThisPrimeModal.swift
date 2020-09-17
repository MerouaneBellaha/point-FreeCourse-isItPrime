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
            state.count.isPrime() ?
                AnyView(PrimeView(state: state)) :
                AnyView(Text("\(state.count) is not Prime"))
        }
        .font(.title)
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
            state.removeFavoritePrime() :
            state.addFavoritePrime()
    }
}
