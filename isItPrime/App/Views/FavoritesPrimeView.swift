//
//  FavoritesPrimeView.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import SwiftUI

struct FavoritesPrimeView: View {
    @ObservedObject var store: Store<AppState, AppAction>

    var body: some View {
        List {
            ForEach(store.value.favoritePrimes, id: \.self) { prime in
                Text(prime.description)
            }
            .onDelete { self.store.send(.favoritePrimes(.deleteFavoritePrimes($0))) }
        }
        .navigationBarTitle("Favorite Primes")
    }
}

struct FavoritesPrimeView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesPrimeView(store: Store(initialValue: AppState(),
                                        reducer: appReducer))
    }
}
