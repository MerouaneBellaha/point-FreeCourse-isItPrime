//
//  ContentView.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var store: Store<AppState, AppAction>

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CounterView(store: self.store)) {
                    Text("CounterDemo")
                }
                NavigationLink(destination: FavoritesPrimeView(store: self.store)) {
                    Text("Favorite Primes")
                }
            }
            .navigationBarTitle("State Management")
        }
    }
}

struct ContentView_Peviews: PreviewProvider {
    static var previews: some View {
        HomeView(store: Store(initialValue: AppState(),
                              reducer: appReducer))
    }
}

// si state est un environmentObject ( possible de ne pas le déclarer ici ? )
