//
//  AppState + Add:RemovePrime.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 17/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

extension AppState {

    func addFavoritePrime() {
        favoritePrimes.append(self.count)
        activityFeed.append(Activity(timestamp: Date(), type: .addedFavoritePrime(count)))
    }

    func removeFavoritePrime(_ prime: Int) {
        favoritePrimes.removeAll(where: { $0 == prime })
        activityFeed.append(Activity(timestamp: Date(), type: .removedFavoritePrime(prime)))
    }

    func removeFavoritePrime() {
        removeFavoritePrime(count)
    }

    func removeFavoritePrimes(at indexSet: IndexSet) {
        indexSet.forEach { removeFavoritePrime(favoritePrimes[$0])}
    }
}
