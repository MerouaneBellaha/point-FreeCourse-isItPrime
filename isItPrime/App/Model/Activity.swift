//
//  Activity.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 17/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

struct Activity {
    let timestamp: Date
    let type: ActivityType

    enum ActivityType {
        case addedFavoritePrime(Int)
        case removedFavoritePrime(Int)
    }
}
