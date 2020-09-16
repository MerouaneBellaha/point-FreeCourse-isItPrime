//
//  ContentView.swift
//  isItPrime
//
//  Created by Merouane Bellaha on 16/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var state: AppState

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CounterView(state: state)) {
                    Text("CounterDemo")
                }
                NavigationLink(destination: FavoritesPrimeView(state: state)) {
                    Text("Favorite Primes")
                }
            }
            .navigationBarTitle("State Management")
        }
    }
}

struct ContentView_Peviews: PreviewProvider {
    static var previews: some View {
        ContentView(state: AppState())
    }
}

