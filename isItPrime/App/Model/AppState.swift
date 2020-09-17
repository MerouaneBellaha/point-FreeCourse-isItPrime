//
//  AppState.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

class AppState: ObservableObject {

    @Published var count: Int { didSet { UserDefaults.standard.set(count, forKey: "count") }}
    @Published var favoritePrimes: [Int] = []

    init(count: Int = 0) {
        self.count = count
    }
}
