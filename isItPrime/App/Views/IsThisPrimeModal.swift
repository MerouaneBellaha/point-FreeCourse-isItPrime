//
//  IsThisPrimeModal.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import SwiftUI

struct IsThisPrimeModal: View {

    @ObservedObject var store: Store<AppState, AppAction>

    var body: some View {

        ZStack {
            store.value.count.isPrime() ?
                AnyView(PrimeView(store: self.store)) :
                AnyView(Text("\(store.value.count) is not Prime"))
        }
        .font(.title)
    }
}

struct IsThisPrimeModal_Previews: PreviewProvider {
    static var previews: some View {
        IsThisPrimeModal(store: Store(initialValue: AppState(),
                                      reducer: appReducer))
    }
}

struct PrimeView: View {

    @ObservedObject var store: Store<AppState, AppAction>
    var isFavorite: Bool { store.value.favoritePrimes.contains(store.value.count) }

    var body: some View {
        VStack {
            Text("\(store.value.count.description) is Prime 🔥")
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
            store.send(.primeModal(.removeFavoritePrimeTapped)) :
            store.send(.primeModal(.saveFavoritePrimeTapped))
    }
}
