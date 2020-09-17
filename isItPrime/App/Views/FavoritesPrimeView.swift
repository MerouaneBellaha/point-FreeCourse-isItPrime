//
//  FavoritesPrimeView.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import SwiftUI

struct FavoritesPrimeView: View {
    @ObservedObject var state: AppState

    var body: some View {
        List {
            ForEach(state.favoritePrimes, id: \.self) { prime in
                Text(prime.description)
            }
            .onDelete { self.state.removeFavoritePrimes(at: $0) }
        }
        .navigationBarTitle("Favorite Primes")
    }
}

struct FavoritesPrimeView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesPrimeView(state: AppState())
    }
}
