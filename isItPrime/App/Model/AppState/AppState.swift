//
//  AppState.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import Foundation

struct AppState {

    var count: Int = UserDefaults.standard.integer(forKey: "count")
    { didSet { UserDefaults.standard.set(count, forKey: "count") }}
    var favoritePrimes: [Int] = []
    var loggedInUser: User?
    var activityFeed: [Activity] = []

    struct Activity {
        let timestamp: Date
        let type: ActivityType

        enum ActivityType {
            case addedFavoritePrime(Int)
            case removedFavoritePrime(Int)
        }
    }
}

extension AppState {
    var favoritePrimesState: FavoritePrimesState {
        get {
            FavoritePrimesState(
                favoritePrimes: self.favoritePrimes,
                activityFeed: self.activityFeed
            )
        }
        set {
            self.favoritePrimes = newValue.favoritePrimes
            self.activityFeed = newValue.activityFeed
        }
    }
}

struct FavoritePrimesState {
    var favoritePrimes: [Int]
    var activityFeed: [AppState.Activity]
}

enum AppAction {
    case counter(CounterAction)
    case primeModal(PrimeModalAction)
    case favoritePrimes(FavoritePrimeAction)
}

enum CounterAction {
    case decrTapped
    case incrTapped
}

enum PrimeModalAction {
    case saveFavoritePrimeTapped
    case removeFavoritePrimeTapped
}

enum FavoritePrimeAction {
    case deleteFavoritePrimes(IndexSet)
}

func favoritePrimesReducer(state: inout FavoritePrimesState, action: AppAction) {
    switch action {
    case let .favoritePrimes(.deleteFavoritePrimes(indexSet)):
        for index in indexSet {
            let prime = state.favoritePrimes[index]
            state.favoritePrimes.remove(at: index)
            state.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(prime)))
        }
    default: break
    }
}

func primeModalReducer(state: inout AppState, action: AppAction) {
    switch action {
    case .primeModal(.saveFavoritePrimeTapped):
        state.favoritePrimes.append(state.count)
        state.activityFeed.append(.init(timestamp: Date(), type: .addedFavoritePrime(state.count)))

    case .primeModal(.removeFavoritePrimeTapped):
        state.favoritePrimes.removeAll(where: { $0 == state.count })
        state.activityFeed.append(.init(timestamp: Date(), type: .removedFavoritePrime(state.count)))
    default: break
    }
}


func counterReducer(state: inout Int, action: AppAction) {
    switch action {
    case .counter(.decrTapped): state -= 1
    case .counter(.incrTapped): state += 1
    default: break
    }
}

func combine<Value, Action>(_ reducers: (inout Value, Action) -> Void...) -> (inout Value, Action) -> Void {
    return { value, action in
        for reducer in reducers {
            reducer(&value, action)
        }
    }
}

func pullback<LocalValue, GlobalValue, Action>(
    _ reducer: @escaping (inout LocalValue, Action) -> Void,
    value: WritableKeyPath<GlobalValue, LocalValue>
) -> (inout GlobalValue, Action) -> Void {
    return { globalValue, action in
        reducer(&globalValue[keyPath: value], action)
    }
}

let _appReducer = combine(
    pullback(counterReducer, value: \.count),
    primeModalReducer,
    pullback(favoritePrimesReducer, value: \.favoritePrimesState)
)

let appReducer = pullback(_appReducer, value: \.self)

// Store<AppState>
final class Store<Value, Action>: ObservableObject {

    @Published var value: Value
    let reducer: (inout Value, Action) -> Void

    init(initialValue: Value,
         reducer: @escaping (inout Value, Action) -> Void) {
        self.value = initialValue
        self.reducer = reducer
    }

    func send(_ action: Action) {
        reducer(&value, action)
    }
}
