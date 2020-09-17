//
//  Int + isPrime.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 17/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

extension Int: Identifiable {
    public var id: String { self.description }

    func isPrime() -> Bool {
        if self <= 1 { return false }
        if self <= 3 { return true }
        for i in 2...Int(sqrt(Float(self))) {
            if self % i == 0 { return false }
        }
        return true
    }
}
